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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = ViewModel()
    private let rowHeight = 200
    private let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        configureTableView()
    }
    
    private func configureTableView() {
        imageListView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        imageListView.delegate = self
        imageListView.dataSource = self
        imageListView.tableFooterView = UIView()
    }
    
    private func getAllPhotos(for text: String) {
        viewModel.searchPhotos(for: text) { [weak self] in
            DispatchQueue.main.async {
                self?.imageListView.reloadData()
            }
        }
    }
    
    private func getImageUrl(for photo: Photo) -> String {
        return "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_w.jpg"
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
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

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getAllPhotos(for: searchText)
    }
}
