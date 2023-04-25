//
//  HomeViewController.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageListView: UITableView!
    
    private let viewModel = ViewModel()
    private let rowHeight = 200
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        addSearchBar()
        configureTableView()
        fetchSearchResult()
    }
    
    private func configureTableView() {
        imageListView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        imageListView.delegate = self
        imageListView.dataSource = self
        imageListView.tableFooterView = UIView()
    }
    
    private func addSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search photos"
        navigationItem.searchController = search
    }
    
    private func getAllPhotos(for text: String) {
        viewModel.searchPhotos(for: text) { [weak self] in
            self?.storeSearchResult(for: text)
            DispatchQueue.main.async {
                self?.imageListView.reloadData()
            }
        }
    }
    
    private func getImageUrl(for photo: Photo) -> String {
        return "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_w.jpg"
    }
    
    private func storeSearchResult(for text: String) {
        let photoList = viewModel.allPhotos
        do {
            let result = try JSONEncoder().encode(photoList)
            if let key = UserDefaults.standard.value(forKey: "key_val") as? String {
                UserDefaults.standard.removeObject(forKey: key)
            }
            UserDefaults.standard.setValue(result, forKey: text)
            UserDefaults.standard.setValue(text, forKey: "key_val")
        } catch {
            print("Failed to store search result: \(error.localizedDescription)")
        }
    }
    
    private func fetchSearchResult() {
        do {
            if let key = UserDefaults.standard.value(forKey: "key_val") as? String {
                let data = UserDefaults.standard.value(forKey: key) as! Data
                let result = try JSONDecoder().decode([Photo].self, from: data)
                viewModel.allPhotos = result
                imageListView.reloadData()
            }
        } catch {
            print("Failed to fetch search result: \(error.localizedDescription)")
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let urlString = getImageUrl(for: viewModel.allPhotos[indexPath.row])
        let url = URL(string: urlString)
        cell.photoView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = viewModel.allPhotos[indexPath.row]
        
        if let imageURL = URL(string: getImageUrl(for: photo)) {
            let imageViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
            imageViewController.imageUrl = imageURL
            navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchTimer?.invalidate()
        guard let searchText = searchController.searchBar.text else { return }
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            self?.getAllPhotos(for: searchText)
        }
    }
}
