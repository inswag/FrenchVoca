//
//  VocabularyCollectionViewTestCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 06/02/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularyCollectionViewTestCell: UICollectionViewCell {
    
    let testSectionPhotos = ["test_FLEX", "test_DELF"]
    let testSectionTitle = ["FLEX", "DELF"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(TestCellNestedCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TestCellNestedCollectionViewCell.self))
        // Anchor 는 클로저 바깥에서 잡아주어야 한다.
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIDesign()
    }
    
    fileprivate func setupUIDesign() {
        self.contentView.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VocabularyCollectionViewTestCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Handle Collection View Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TestCellNestedCollectionViewCell.defineCellSize(cellwidth: 120)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TestCellNestedCollectionViewCell.self), for: indexPath) as! TestCellNestedCollectionViewCell
        
        cell.imageView.image = UIImage(named: testSectionPhotos[indexPath.row])
        cell.levelTitle.text = testSectionTitle[indexPath.row]
        return cell
    }
    
}
