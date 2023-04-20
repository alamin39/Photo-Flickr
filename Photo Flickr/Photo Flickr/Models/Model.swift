//
//  Model.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import Foundation


struct AllPhotos: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
}

struct Photo: Codable {
    let id, owner, secret, server: String
    let title: String?
}
