//
//  ShuffleSongsFetchTests.swift
//  ShuffleSongsTests
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import XCTest
@testable import ShuffleSongs

class ShuffleSongsFetchTests: XCTestCase {

    var promise: XCTestExpectation!
    var songs: [Result]?
    override func setUp() {
        promise = expectation(description: "Request")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSongsShouldReturnListOfTracks() {
        let model = SongsViewModel(s: SongsService())
        let ids = ["909253", "1171421960", "358714030", "1419227", "264111789"]
        model.delegate = self
        model.songs(ids: ids)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testShuffleShouldReturnListOfTracks() {
        let model = SongsViewModel(s: SongsService())
        let ids = ["909253", "1171421960", "358714030", "1419227", "264111789"]
        model.delegate = self
        model.songs(ids: ids)
        waitForExpectations(timeout: 60, handler: nil)
        
        model.shuffleSongs(songs: songs ?? [])
    }
}

extension ShuffleSongsFetchTests: SongsDelegate {
    func success(_ results: [Result]) {
        songs = results
        XCTAssertTrue(results.count > 0)
        
        let song = results.first
        XCTAssertNotNil(song?.trackName)
        XCTAssertNotNil(song?.artistId)
        XCTAssertNotNil(song?.artworkUrl)
        XCTAssertNotNil(song?.artistName)
        
        promise.fulfill()
    }
    
    func fail(message: String) {
        XCTAssertNotNil(message)
        promise.fulfill()
    }
    
    func shuffled(_ songs: [Result]) {
        XCTAssertTrue(songs.count > 0)
        
        let song = songs.first
        XCTAssertNotNil(song?.trackName)
        XCTAssertNotNil(song?.artistId)
        XCTAssertNotNil(song?.artworkUrl)
        XCTAssertNotNil(song?.artistName)
    }
}
