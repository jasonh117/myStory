//
//  MyStoryTests.swift
//  MyStoryTests
//
//  Created by Jason Chen-Ju Hsieh on 11/7/15.
//  Copyright © 2015 Team 19. All rights reserved.
//

import XCTest
@testable import MyStory

class MyStoryTests: XCTestCase {
    
    // MARK: MyStory Tests
    
    // Tests that name returns
    func testNameReturns() {
        // Success case
        let potentialItem = Memories(name: "jason", photo: nil, photoDescription: "guy")
        XCTAssertNotNil(potentialItem)
    }
    
}
