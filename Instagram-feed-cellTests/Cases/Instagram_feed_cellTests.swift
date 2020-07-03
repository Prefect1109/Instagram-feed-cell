//
//  Instagram_feed_cellTests.swift
//  Instagram-feed-cellTests
//
//  Created by Богдан Ткачук on 30.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import XCTest
@testable import Instagram_feed_cell

class Instagram_feed_cellTests: XCTestCase {
    
    func testTimeAgoStrings() {
        // Cheking Time Ago extension method for Int data type
        let tenMinutesAgo = Date(timeIntervalSinceNow: -10 * 60)
        let oneHourAgo = Date(timeIntervalSinceNow: -60 * 60)
        
        let tenMinutesForShowing = tenMinutesAgo.timeAgo()
        let oneHourForShowing = oneHourAgo.timeAgo()
        
        XCTAssertEqual(tenMinutesForShowing, "10 minutes ago")
        XCTAssertEqual(oneHourForShowing, "1 hour ago")
    }
    
    func checkThatJsonNotEmpty(){
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        Feed.lastPosts.removeAll()
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "posts", withExtension: "json")!)
        let decodeData = try! decoder.decode([PostJson].self, from: data)
        
        XCTAssertEqual(decodeData[0].accountId, "pre_fect")
    }
    
    
}
