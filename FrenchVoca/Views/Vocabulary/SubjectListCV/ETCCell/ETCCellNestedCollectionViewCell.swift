//
//  ETCCellNestedCollectionViewCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 09/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class ETCCellNestedCollectionViewCell: UICollectionViewCell {
    
    static func defineCellSize(cellwidth: CGFloat) -> CGSize {
        let cellHeight = (Constant.totalMargin) +
            (Constant.imageHeight) +
            (Constant.levelTitle!.lineHeight)
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    struct Constant {
        static let totalMargin: CGFloat = 16
        static let imageHeight: CGFloat = 50 // 약간의 마진때문에 구분선이 사라져서 +3 추가
        static let levelTitle = UIFont(name: "Avenir-Light", size: 10)
        
    }
    
    let customView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 80)) // 120/80 (80: 50 + 30)
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.rgb(red: 251, green: 132, blue: 132)
        return iv
    }()
    
    let levelTitle: UILabel = {
        let label = UILabel()
        label.text = "Débutant"
        label.font = UIFont(name: "Avenir-Light", size: 10)
        label.textColor = UIColor.rgb(red: 73, green: 72, blue: 72)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUIDesign() {
        self.contentView.addSubview(customView)
        self.customView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.customView.addSubview(imageView)
        self.customView.addSubview(levelTitle)
        self.imageView.anchor(top: self.customView.topAnchor, left: self.customView.leftAnchor, bottom: nil, right: self.customView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        self.levelTitle.anchor(top: self.imageView.bottomAnchor, left: self.customView.leftAnchor, bottom: self.customView.bottomAnchor, right: self.customView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        
        
        //        self.customView.layer.cornerRadius = 3.0
        //        self.customView.layer.masksToBounds = true
        //        self.customView.layer.borderColor = UIColor.rgb(red: 255, green: 255, blue: 255).cgColor
        self.imageView.layer.cornerRadius = 3.0
        self.imageView.layer.masksToBounds = true
        print("OK")
    }
    
}
