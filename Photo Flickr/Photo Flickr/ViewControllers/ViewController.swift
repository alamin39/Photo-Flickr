//
//  ViewController.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageListView: UITableView!
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        configureTableView()
        getAllPhotos(for: "mango")
    }
    
    private func configureTableView() {
        imageListView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        imageListView.delegate = self
        imageListView.dataSource = self
        imageListView.tableFooterView = UIView()
    }
    
    private func getAllPhotos(for text: String) {
        viewModel.searchPhotos(query: text) { [weak self] in
            DispatchQueue.main.async {
                self?.imageListView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let urlString = getImageUrl(photo: viewModel.allPhotos[indexPath.row])
        let url = URL(string: urlString)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.photoView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func getImageUrl(photo: Photo) -> String {
        return "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_w.jpg"
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = viewModel.allPhotos[indexPath.row]
        
        if let imageURL = URL(string: getImageUrl(photo:user)) {
            let imageViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
            
            DispatchQueue.global().async {
                imageViewController.data = try? Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(imageViewController, animated: true)
                }
            }
        }
    }
}
