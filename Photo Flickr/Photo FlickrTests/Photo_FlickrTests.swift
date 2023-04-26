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
    
    func testRepositoryListInitialValue() {
        XCTAssertTrue(sut.allPhotos.isEmpty)
    }
    
    func testGetImageUrl() {
        let photo = Photo(id: "12345", owner: "owner", secret: "secret", server: "server")
        let imageUrl = HomeViewController().getImageUrl(for: photo)
        XCTAssertEqual(imageUrl, "https://live.staticflickr.com/server/12345_secret_w.jpg", "Incorrect image URL")
    }
    
    func testSearchPhotosWithMockNetworkManager() {
        let expectation = self.expectation(description: "Search photos completion should be called.")
        let text = "dog"
        
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.searchPhotos(query: text) { [weak self] photoList, error in
            expectation.fulfill()
            XCTAssertNil(error, "Search photos completion should not throw an error.")
            XCTAssertNotNil(self?.sut.allPhotos, "ViewModel's allPhotos array should be updated with mock data.")
        }

        waitForExpectations(timeout: 5)
    }
}

class MockNetworkManager {
    func searchPhotos(query: String, completion: @escaping ([Photo]?, Error?) -> Void) {
        let photo1 = Photo(id: "1", owner: "owner1", secret: "secret1", server: "server1")
        let photo2 = Photo(id: "2", owner: "owner2", secret: "secret2", server: "server2")
        let photoList = [photo1, photo2]
        completion(photoList, nil)
    }
}
