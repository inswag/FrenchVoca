//
//  VocabularyWordbookVC.swift
//  FrenchVoca
//
//  Created by 박인수 on 29/08/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class VocabularyNotebookVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .blue
        self.tableView.register(VocabularyNotebookVCCell.self, forCellReuseIdentifier: String(describing: VocabularyNotebookVCCell.self))
    }
}

extension VocabularyNotebookVC {
    
    
    
}
