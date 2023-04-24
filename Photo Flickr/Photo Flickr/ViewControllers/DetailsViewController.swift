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
            photoView.enableZoom()
        }
    }
}

extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
