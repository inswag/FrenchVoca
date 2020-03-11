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
    
    let InstitutLogo: UILabel = {
        let label = UILabel()
        label.text = "Institut Français"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        return label
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let koreanTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "프랑스 문화/공연/교육/예술 정보"
        label.textAlignment = .center
        label.font = Tools.font.appleSDGothicNeoBold(size: 18)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subFrenchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "(Informations chez Institut Français)"
        label.textAlignment = .center
        label.font = Tools.font.avenirMedium(size: 18)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
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
        self.navigationItem.titleView = InstitutLogo
        self.view.backgroundColor = .white
        
        [tableView, headerView].forEach {
            self.view.addSubview($0)
        }
        
        [koreanTitleLabel, subFrenchTitleLabel].forEach {
            self.headerView.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.width.equalTo(self.view.frame.width)
            $0.height.equalTo(80)
        }
        
        koreanTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(subFrenchTitleLabel.snp.top)
        }
        
        subFrenchTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
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

        // Todo:- must change tableview structure
//        cell.viewModel = InstitutInfoCellViewModel(contents: <#T##InstitutInfo#>)
        return cell
    }
    
}

// MARK:- Table View Delegate

extension InstitutViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 + 16 + 8 + 20
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
