//
//  VocabularyNotebookVCCell.swift
//  FrenchVoca
//
//  Created by 박인수 on 29/08/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularyNotebookVCCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: VocabularyNotebookVCCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
