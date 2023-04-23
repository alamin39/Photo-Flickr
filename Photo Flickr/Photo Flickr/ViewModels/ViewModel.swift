//
//  ViewModel.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import Foundation

final class ViewModel {
    
    private(set) var allPhotos = [Photo]()
    
    func searchPhotos(for text: String, completion: @escaping() -> Void) {
        NetworkManager.shared.searchPhotos(query: text) { [weak self] photoList, error in
            guard let photoList = photoList else {
                return
            }
            self?.allPhotos = photoList.photos.photo
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
