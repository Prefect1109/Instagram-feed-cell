//
//  HomeViewController.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 23.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UICollectionViewController {
    
    //MARK: - View
    let loader : UIActivityIndicatorView = {
        let actv = UIActivityIndicatorView()
        actv.color = .white
        actv.isHidden = true
        actv.style = .large
        return actv
    }()
    
    let backgroundViewForLoader: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.alpha = 0
        return view
    }()
    
    
    //MARK: - Variables
    var posts : [Post] = [Post]()
    var filteredPosts: [Post] {
        return posts.sorted { $0.postJson.creationDate.compare($1.postJson.creationDate) == .orderedDescending }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        Delegate.instagramManager.delegate = self
        
        // View Setup
        setupView()
        
        // Add post items to array
        Delegate.instagramManager.decodeJson()
        shouldSpin(true)
        
    }
    
    private func setupView(){
        
        // Setuping collection(posts) views
        collectionView?.backgroundColor = .white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: K.feedCellId)
        
        // Setup refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        // Setuping navBar
        setupNavBar()
    }
    
    @objc func handleRefresh(){
        
        self.collectionView?.reloadData()
        self.collectionView?.refreshControl?.endRefreshing()
    }
    
    // Func for getting dynamic cell heigh
    private func getMaxContentHeigh(_ index: Int){
        // TODO: make resizing for smaller images and larger
        
        //        for content in posts[index].contentPhotos!{
        //
        //            if K.maxContentHeigh < content.size.height{
        //                K.maxContentHeigh = content.size.height
        //            }
        //
        //        }
        
        K.maxContentHeigh = UIScreen.main.bounds.size.width
        
    }
    
    func shouldSpin(_ spin: Bool){
        if spin{
            loader.isHidden = false
            loader.startAnimating()
            backgroundViewForLoader.alpha = 0.9
        } else {
            loader.isHidden = true
            loader.stopAnimating()
            backgroundViewForLoader.alpha = 0
        }
    }
    
    private func setupNavBar(){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(#imageLiteral(resourceName: "camera") , for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(#imageLiteral(resourceName: "sent") , for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(openDirect), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setLeftBarButton(item1, animated: true)
        self.navigationItem.setRightBarButton(item2, animated: true)
    }
    
    // NavBar buttons methods
    @objc func openCamera(){
        // Opening Camera
    }
    
    @objc func openDirect(){
        // Opening direct
    }
    
}

// MARK: - UICollectionViewController
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        getMaxContentHeigh(indexPath.row)
        
        K.numberOfPages = filteredPosts[indexPath.row].contentPhotos!.count
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.feedCellId, for: indexPath) as! FeedCell
        
        cell.post = filteredPosts[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 //header of cell
        height += view.frame.width // image
        height += 150 // bottom
        
        return CGSize(width: view.frame.width, height: height)
    }
}

//MARK: - Intstagram manager(networking) methods
extension HomeViewController : InstagramManagerDelegate{
    func fetchPosts() {
        self.posts = Feed.lastPosts
        
        self.collectionView?.reloadData()
        shouldSpin(false)
    }
}
