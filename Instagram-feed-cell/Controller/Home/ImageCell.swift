//
//  ImageCell.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 26.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ImageCell: UICollectionViewCell {
    
    //MARK: - UI
    
    let contentImageView : UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView = contentImageView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
