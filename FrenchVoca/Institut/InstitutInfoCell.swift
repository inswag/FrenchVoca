//
//  InstitutInfoCell.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/03/11.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import Kingfisher

class InstitutInfoCell: TableViewCell {
    
    // MARK:- Properties
    
//    var viewModel: InstitutInfoCellViewModel! {
//        didSet {
//            self.noticeTitleLabel.text = viewModel.title
//
//            let url = URL(string: viewModel.image)!
//            self.noticeimageView.kf.setImage(with: url)
//        }
//    }
    
    // MARK:- Constant
    
    struct Constant {
        static let topMargin: CGFloat = 16
        static let leadingMargin: CGFloat = 16
        static let trailingMargin: CGFloat = -16
        static let bottomMargin: CGFloat = -16
        static let imageViewTopMargin: CGFloat = 8
        
        static let collectionViewHeight: CGFloat = 200 // 228
        static let noticeCellTitleFont = Tools.font.avenirLight(size: 18)
        static let noticeCellSubTitleFont = Tools.font.appleSDGothicNeoBold(size: 12)
    }
    
    let noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Annonces"
        label.textAlignment = .left
        label.font = Constant.noticeCellTitleFont
        label.textColor = Tools.color.mediumBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let noticeimageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 1
        imgView.layer.cornerRadius = 6
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: InstitutViewController.self))
//        self.backgroundColor = .red
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUIComponents() {
        [noticeTitleLabel, noticeimageView].forEach {
            addSubview($0)
        }
    }
    
    override func setupUILayout() {
        noticeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constant.leadingMargin)
            $0.trailing.equalToSuperview().offset(Constant.trailingMargin)
        }
        
        noticeimageView.snp.makeConstraints {
            $0.top.equalTo(noticeTitleLabel.snp.bottom).offset(Constant.imageViewTopMargin)
            $0.leading.equalToSuperview().offset(Constant.leadingMargin)
            $0.trailing.equalToSuperview().offset(Constant.trailingMargin)
            $0.height.equalTo(180)
            $0.bottom.equalToSuperview().offset(Constant.bottomMargin)
        }
    }
    
    override func prepareForReuse() {
        noticeTitleLabel.text = nil
        noticeimageView.image = nil
    }
    
    
    
}
