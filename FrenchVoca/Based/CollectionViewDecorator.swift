//
//  CollectionViewDecorator.swift
//  FrenchVoca
//
//  Created by 박인수 on 26/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewDecorator {

  func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    
}
