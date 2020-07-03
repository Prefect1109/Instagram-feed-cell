//
//  Constans.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 25.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation
import UIKit

struct K {
    
    // Cell properties
    static let feedCellId = "feedCellId"
    
    static let contentCellId = "ContentCellId"
    
    // Boofer entites
    static var maxContentHeigh = CGFloat(100)
    
    static var numberOfPages = 1
    
}

struct Delegate {
    // Delegates
    static var instagramManager = InstagramManager()
}

struct Feed {
    
    // Boofer feed
    static var lastPosts : [Post] = [Post]()
}


//MARK: - Color constans

struct Color {
    static let brandWhite = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
}

struct Font {
    static let regular = "Helvetica Neue"
    static let bold = "HelveticaNeue-Medium"
}
