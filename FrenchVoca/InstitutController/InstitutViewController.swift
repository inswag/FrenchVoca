//
//  InstitutViewController.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/03/10.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftSoup


class InstitutViewController: ViewController {
    
    // MARK:- Properties
    
    let navigator: Navigator
    let viewModel: InstitutViewControllerViewModel
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(InstitutInfoCell.self,
                    forCellReuseIdentifier: String(describing: InstitutInfoCell.self))
        return tv
    }()
    
    // MARK:- Initialize
    
    init(navigator: Navigator, viewModel: InstitutViewControllerViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         fetchResult()
        
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        self.view.backgroundColor = .white
        
        [tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK:- Methods
    
    func fetchResult() {
        viewModel.fetchHTMLParsingResult {
            print("Finish")
        }
    }
    

}


// MARK:- Table View Data Source

extension InstitutViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InstitutInfoCell.self), for: indexPath) as? InstitutInfoCell else { return UITableViewCell() }
        
        cell.noticeTitleLabel.text = viewModel.titleArray[indexPath.row]
        
        let url = URL(string: viewModel.imageArray[indexPath.row])!
        
        cell.noticeimageView.kf.setImage(with: url)
        
        return cell
    }
    
}

// MARK:- Table View Delegate

extension InstitutViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 + 16 + 8 + 20
    }
}
