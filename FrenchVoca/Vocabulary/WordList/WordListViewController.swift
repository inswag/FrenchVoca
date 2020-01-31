//
//  WordListViewController.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/01/31.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import SnapKit

class WordListViewController: UIViewController {
    
    // MARK:- Properties
    
//    let navigate: Navigator
//    let viewModel: ProductControllerViewModel
    
    // MARK:- UI Properties
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(WordListCell.self, forCellReuseIdentifier: String(describing: WordListCell.self))
        return tv
    }()
    
    lazy var closeButton: UIButton = {
        let btn = UIButton()
        let btnImg = UIImage(named: "close_white")
        btn.setImage(btnImg, for: .normal)
        btn.backgroundColor = UIColor.rgb(r: 24, g: 24, b: 40, a: 0.16)
        btn.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    @objc func actionClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var purchaseButton: UIButton = {
        let btn = UIButton()
//        btn.backgroundColor = UIColor.colorWithHexString(hexString: "#9013FE")
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("구매하기", for: .normal)
//        btn.titleLabel?.font = Tools.font.notoSansCJKkrBlack(size: 18.0)
        btn.layer.cornerRadius = 14
        return btn
    }()
    
    // MARK:- Initialize
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- UI Method
    
    func setupUIComponents() {
        
        // transparent background
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        // UI Layouts
        [borderView, tableView, closeButton, purchaseButton].forEach { self.view.addSubview($0) }
        
        borderView.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            m.width.equalTo(80)
            m.height.equalTo(6)
            m.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(borderView.snp.bottom).offset(8)
            m.leading.trailing.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { (m) in
            m.top.equalTo(tableView.snp.top).offset(16)
            m.trailing.equalTo(tableView.snp.trailing).offset(-16)
            m.width.equalTo(40)
            m.height.equalTo(40)
        }
        
        purchaseButton.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(30)
            m.height.equalTo(52)
            
        }
        
    }
    

    
}

extension WordListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            return UITableViewCell()
        }
        
    }
    
    
}

extension WordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return UITableView.automaticDimension

        
    }
}
