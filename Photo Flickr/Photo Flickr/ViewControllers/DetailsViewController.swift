//
//  DetailsViewController.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var data: Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = data {
            DispatchQueue.main.async {
                self.photoView.image = UIImage(data: data)
            }
        }
    }
}
