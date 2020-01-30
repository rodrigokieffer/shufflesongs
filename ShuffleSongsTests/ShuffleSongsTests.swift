//
//  ShuffleSongsTests.swift
//  ShuffleSongsTests
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import XCTest
@testable import ShuffleSongs

class ShuffleSongsTests: XCTestCase {

    var songsVC: SongsTableViewController!
    var promise: XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nav.viewControllers.first as! SongsTableViewController
        songsVC = vc
        _ = songsVC.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatViewLoads() {
        XCTAssertNotNil(songsVC.view, "View not initiated properly")
    }
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(songsVC.tableView, "TableView not initiated")
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(songsVC.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testThatTableViewHasDataSource() {
        XCTAssertNotNil(songsVC.tableView.dataSource, "TableView datasource cannot be nil")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue(songsVC.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(songsVC.tableView.delegate, "TableView delegate cannot be nil")
    }

}
