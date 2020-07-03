//
//  FeedCell.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 25.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class FeedCell: UICollectionViewCell {
    
    var post : Post? {
        didSet {
            accountIdLabel.text = post!.postJson.accountId
            accountPhoto.image = post!.accountPhoto
            ImageArray = post!.contentPhotos!
            
            // If we have only one photo in post, we dont need to show page control
            if post!.contentPhotos!.count == 1{
                pageControl.removeFromSuperview()
            }
            
            likedByLabel.attributedText = getLikesLabelText(post!.postJson.likesFromAccounts)
            likedByLabel.sizeToFit()
            
            contentLabel.attributedText = getContentLabelText(post!)
            contentLabel.sizeToFit()
            
            timeAgoLabel.text = Date(timeIntervalSince1970: TimeInterval(exactly: Double(post!.postJson.creationDate)!)!).timeAgo()
        }
    }
    
    //MARK: - UI
    
    var ImageArray : [UIImage] = [UIImage]()
    
    // Top view
    private let accountPhoto : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor(red: 214/255, green: 216/255, blue: 218/255, alpha: 1).cgColor
        return imgView
    }()
    
    private let accountIdLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Font.bold, size: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let locationName : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("location name", for: .normal)
        btn.titleLabel?.font =  UIFont(name: Font.regular, size: 14)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    private let moreInfoButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("•••", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
   // Content view
    let swipeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 10, height: 10), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // Bottom analytic view
    let likeButton : UIButton = {
        let btn = UIButton()
        btn.isEnabled = true
        btn.setBackgroundImage(#imageLiteral(resourceName: "like"), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.clipsToBounds = true
        return btn
    }()
    
    let commentButton : UIButton = {
        let btn = UIButton()
        btn.isEnabled = true
        btn.setBackgroundImage(#imageLiteral(resourceName: "comment"), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.clipsToBounds = true
        return btn
    }()
    
    let sentButton : UIButton = {
        let btn = UIButton()
        btn.isEnabled = true
        btn.setBackgroundImage(#imageLiteral(resourceName: "sent"), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.clipsToBounds = true
        return btn
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = K.numberOfPages
        pc.currentPageIndicatorTintColor = UIColor(displayP3Red: 48/255, green: 148/255, blue: 253/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(displayP3Red: 219/255, green: 219/255, blue: 219/255, alpha: 1)
        return pc
    }()
    
    let savePostButton : UIButton = {
        let btn = UIButton()
        btn.isEnabled = true
        btn.setBackgroundImage(#imageLiteral(resourceName: "saved"), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.clipsToBounds = true
        return btn
    }()
    
    let likedByLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Font.regular, size: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // Bottom text content view
    let contentLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Font.regular, size: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // Timeline Info view
    let timeAgoLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 214/255, green: 216/255, blue: 218/255, alpha: 1)
        lbl.font = UIFont(name: Font.regular, size: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        // Swipe collection view setup
        swipeCollectionView.backgroundColor = .white
        
        swipeCollectionView.delegate = self
        swipeCollectionView.dataSource = self
        
        swipeCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: K.contentCellId)
        
        swipeCollectionView.isScrollEnabled = true
        
        // Add views
        addSubview(accountPhoto)
        addSubview(accountIdLabel)
        addSubview(locationName)
        addSubview(moreInfoButton)
        
        addSubview(swipeCollectionView)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(sentButton)
        addSubview(pageControl)
        addSubview(savePostButton)
        
        addSubview(likedByLabel)
        
        addSubview(contentLabel)
        
        addSubview(timeAgoLabel)
        
        // Setup layout for items
        // Top view
        accountPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.height.width.equalTo(40)
        }
        
        accountIdLabel.snp.makeConstraints { (make) in
            make.left.equalTo(accountPhoto.snp.right).offset(20)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.equalTo(moreInfoButton).offset(-20)
        }
        
        moreInfoButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.centerY.equalTo(accountPhoto)
            make.height.width.equalTo(20)
        }
        
        locationName.snp.makeConstraints { (make) in
            make.left.equalTo(accountPhoto.snp.right).offset(20)
            make.top.equalTo(accountIdLabel.snp.bottom)
        }
        
        // Content view
        swipeCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(accountPhoto.snp.bottom).offset(10)
            make.height.equalTo(K.maxContentHeigh)
        }
        
        // Bottom analytic view
        likeButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(swipeCollectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.left.equalTo(likeButton.snp.right).offset(15)
            make.top.equalTo(swipeCollectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        
        sentButton.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right).offset(15)
            make.top.equalTo(swipeCollectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(swipeCollectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        
        savePostButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.top.equalTo(swipeCollectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        
        likedByLabel.snp.makeConstraints { (make) in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
        }
        
        // Bottom text content view
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(likedByLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
        }
        
        // Timeline Info view
        timeAgoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.right.equalTo(contentView.snp.right).offset(-15)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // So many code for NSMutableAttributedString, for getting bold text in the part of string
    private func getContentLabelText(_ post: Post) -> NSAttributedString {
        let label = NSMutableAttributedString(string: post.postJson.accountId, attributes: [NSAttributedString.Key.font: UIFont(name: Font.bold, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ])
        let additionalValue1 = NSAttributedString(string: " \(post.postJson.contentText)", attributes: [NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ])
        
        label.append(additionalValue1)
        
        return label
    }
    
    // So many code for NSMutableAttributedString, for getting bold text in the part of string
    private func getLikesLabelText(_ accs: [String]) -> NSAttributedString {
        
        // In method showRandomAccountsArray we checking count of likes
        if let safeArray = showRandomAccountsArray(accs){
            
            // In the case that we have < 5 Likes we need to write "Liked by someone... and 3 another"
            let likeString = NSMutableAttributedString(string: "Liked by ", attributes: [NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ])
            for accountName in safeArray{
                if accountName == safeArray[0]{
                    
                    // Checked that it's first word, because we not need koma before accountId
                    likeString.append(NSAttributedString(string: "\(accountName)", attributes: [NSAttributedString.Key.font: UIFont(name: Font.bold, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ]))
                } else {
                    
                    // Here we need koma because need separation for correct view
                    likeString.append(NSAttributedString(string: ", \(accountName)", attributes: [NSAttributedString.Key.font: UIFont(name: Font.bold, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ]))
                }
            }
            
            // Piece of design :0
            // We need word "and" as regular font, and " {countOfLikes} others" bold font
            likeString.append(NSAttributedString(string: " and", attributes: [NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ]))
            likeString.append(NSAttributedString(string: " \(accs.count - safeArray.count) others", attributes: [NSAttributedString.Key.font: UIFont(name: Font.bold, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ]))
            
            return likeString
        } else {
            
            // In the case that we have not < 5 Likes we need to write "Likes 123"
            let likeCount = NSMutableAttributedString(string: "Likes ", attributes: [NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ])
            likeCount.append(NSAttributedString(string: "\(accs.count)", attributes: [NSAttributedString.Key.font: UIFont(name: Font.bold, size: 14.0) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1) ]))
            return likeCount
        }
    }
    
    private func showRandomAccountsArray(_ accs: [String]) -> [String]?{
        var randomAccs : [String] = [String]()
        
        // Next line cheks we have 5 or more likes or not (min 3 labels of accounts and 2 others likes)
        if accs.count < 5{return nil}
        
        let shuffledSequence = accs.shuffled()
        for i in 0...2 {
            randomAccs.append(shuffledSequence[i])
        }
        return randomAccs
    }
    
}


extension FeedCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post!.contentPhotos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = swipeCollectionView.dequeueReusableCell(withReuseIdentifier: K.contentCellId, for: indexPath) as! ImageCell
        
        cell.contentImageView.image = post?.contentPhotos![indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: swipeCollectionView.frame.width, height: swipeCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / contentView.frame.width)
    }
    
}
