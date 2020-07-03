//
//  AddContentViewController.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 25.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit
import SnapKit

class AddContentViewController: UIViewController {
    
    let testLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Font.bold, size: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = Color.brandWhite
        
        // Adding label
        view.addSubview(testLabel)
        
        testLabel.text = "AddContentViewController"
        
        testLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
        }
        
    }
}
