//
//  DetailsViewController.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var imageUrl: URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        if let imageUrl = imageUrl {
           photoView.kf.setImage(with: imageUrl)
        }
    }
}
