//
//  Photo_FlickrTests.swift
//  Photo FlickrTests
//
//  Created by Al-Amin on 2023/04/20.
//

import XCTest
@testable import Photo_Flickr

final class Photo_FlickrTests: XCTestCase {
    
    var sut: ViewModel!
    
    override func setUp() {
        sut = ViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_RepositoryList_InitialValue() {
        XCTAssertTrue(sut.allPhotos.isEmpty)
    }
    
}
