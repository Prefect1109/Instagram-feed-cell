//
//  InstagramManager.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 30.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol InstagramManagerDelegate {
    func fetchPosts()
}

class InstagramManager {
    
    var delegate : InstagramManagerDelegate?
    
    // Decode main Json
    func decodeJson(){
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        Feed.lastPosts.removeAll()
        do {
            let data = try Data(contentsOf: Bundle.main.url(forResource: "posts", withExtension: "json")!)
            let decodeData = try decoder.decode([PostJson].self, from: data)
            for post in decodeData{
                let jsonPost = PostJson(accountId: post.accountId, accountPhotoUrl: post.accountPhotoUrl, locationName: post.locationName, contentPhotosUrls: post.contentPhotosUrls, likesFromAccounts: post.likesFromAccounts, contentText: post.contentText, creationDate: post.creationDate)
                print(downloadPhotos(jsonPost))
            }
        } catch {
            print("Error with parsing data: \(error)")
            
        }
        print("Success decoding  List data")
        
    }
    
    private func downloadPhotos(_ pj: PostJson) -> Promise<[UIImage]> {
        return Promise { seal in
            // Get photos for swipe Collection View
            var contentPhotos : [UIImage] = [UIImage]()
            for photoUrl in pj.contentPhotosUrls {
                guard let photoData = try? Data(contentsOf: photoUrl) else {
                    return
                }
                guard let photoImage = UIImage(data: photoData) else {
                    return
                }
                contentPhotos.append(photoImage)
                
            }
            
            // Get user PhotoIMage
            guard let userPhotoData = try? Data(contentsOf: pj.accountPhotoUrl) else {
                return
            }
            guard let userImage = UIImage(data: userPhotoData) else {
                return
            }
            
            Feed.lastPosts.append(Post(postJson: pj, accountPhoto: userImage, contentPhotos: contentPhotos))
            print("Finished downloading  photos")
            self.delegate?.fetchPosts()
        }
    }
}
