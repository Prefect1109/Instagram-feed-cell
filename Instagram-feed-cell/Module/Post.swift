//
//  Post.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 25.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct PostJson : Codable {
    
    // Top view
    var accountId : String
    var accountPhotoUrl : URL
    var locationName : String?
    
    // Content
    var contentPhotosUrls : [URL]
    
    // Analytic view
    var likesFromAccounts: [String]
    
    // Content text
    var contentText : String
    
    // Timeline Info
    var creationDate : String
    
    
}

struct Post {
    var postJson : PostJson
    
    var accountPhoto : UIImage?
    
    var contentPhotos : [UIImage]?
    
}
