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
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.grouped)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(InstitutInfoCell.self,
                    forCellReuseIdentifier: String(describing: InstitutInfoCell.self))
        return tv
    }()
    
    let institutLogo: UILabel = {
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
        label.text = "한국에서의 프랑스 문화와 예술"
        label.textAlignment = .center
        label.font = Tools.font.appleSDGothicNeoBold(size: 18)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subFrenchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "(Arts et Cultures Français en Corée)"
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
        self.navigationItem.titleView = institutLogo
        self.view.backgroundColor = .white
        activityIndicator.alpha = 1.0
        
        [tableView, headerView, activityIndicator].forEach {
            self.view.addSubview($0)
        }
        
        [koreanTitleLabel, subFrenchTitleLabel].forEach {
            self.headerView.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(self.view.frame.width)
            $0.height.equalTo(70)
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
        
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global().async {
            self.viewModel.fetchHTMLParsingResultWill {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        
        
        
//        viewModel.fetchHTMLParsingResultNow {
//            print("Now Finish")
//        }
    }
    

}


// MARK:- Table View Data Source

extension InstitutViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return InstitutViewControllerViewModel.CellType.totalCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            print("will : ", viewModel.willTitleArray.count)
            return viewModel.willTitleArray.count
        case 1:
            print("now : ", viewModel.nowTitleArray.count)
            return viewModel.nowTitleArray.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InstitutInfoCell.self),
                                                       for: indexPath) as? InstitutInfoCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.noticeTitleLabel.text = "🇫🇷 \(viewModel.willTitleArray[indexPath.row]) 🇰🇷"
            let url = URL(string: viewModel.willImageArray[indexPath.row])!
            cell.noticeimageView.kf.setImage(with: url)
            
            // Todo:- must change tableview structure
            //        cell.viewModel = InstitutInfoCellViewModel(contents: <#T##InstitutInfo#>)
            return cell
        case 1:
            cell.noticeTitleLabel.text = "🇫🇷 \(viewModel.nowTitleArray[indexPath.row]) 🇰🇷"
            let url = URL(string: viewModel.nowImageArray[indexPath.row])!
            cell.noticeimageView.kf.setImage(with: url)
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
}

// MARK:- Table View Delegate

extension InstitutViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 + 16 + 8 + 20
    }
    
//    func tableView(_ tableView: UITableView,
//                   viewForHeaderInSection section: Int) -> UIView? {
//
//        switch section {
//        case 0:
//            return headerView
//        default:
//            return headerView
//        }
////        return headerView
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "준비 중인 이벤트"
        default:
            return "진행 중인 이벤트"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.systemFont(ofSize: 24.0)
            header.textLabel!.textColor = UIColor.orange
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let urlString = viewModel.willNextArray[indexPath.row]
            self.navigationController?.pushViewController(navigator.get(segue: .institutDetail(url: urlString)), animated: true)
        default:
            let urlString = viewModel.nowNextArray[indexPath.row]
            self.navigationController?.pushViewController(navigator.get(segue: .institutDetail(url: urlString)), animated: true)
        }
        
    }
}
