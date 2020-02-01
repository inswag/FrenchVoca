//
//  WordListViewController.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/01/31.
//  Copyright © 2020 inswag. All rights reserved.
//

import AVFoundation
import UIKit
import SnapKit

class WordListViewController: UIViewController {
    
    // MARK:- Properties
    
    let navigate: Navigator
//    let viewModel: ProductControllerViewModel
  
    var wordDAO = WordDAO()
    var subjectDAO = SubjectDAO()
    var wordList: [WordVO]!
    var subjectInfo: [SubjectVO]!
    var indexPath: Int = 0
    
    // MARK:- UI Properties
    
    lazy var popImageButton: UIButton = {
        let btn = UIButton()
        let btnImg = "Pop_Black_Button"
        btn.setImage(UIImage(named: btnImg), for: .normal)
        btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var popTextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Arrière", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var optionButton: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "options"), for: .normal)
        btn.addTarget(self, action: #selector(actionOption), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionOption() {
        self.present(navigate.get(segue: .voiceSetting), animated: true, completion: nil)
    }
    
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
    
    // MARK:- Initialize
    
    init(navigator: Navigator) {
        self.navigate = navigator
        super.init(nibName: nil, bundle: nil)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        self.view.backgroundColor = .red
        
        self.wordList = self.wordDAO.find(subjectCd: indexPath)
        self.subjectInfo = self.subjectDAO.get(subjectCd: indexPath)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Application.shared.synthesizer.isSpeaking == true {
            Application.shared.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
    // MARK:- UI Method
    
    func setupUIComponents() {
//
////        // transparent background
////        self.view.isOpaque = false
////        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
//
        // UI Layouts
        [tableView].forEach { self.view.addSubview($0) }
//
        tableView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.bottom.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
        }
    }
//

    
}

extension WordListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {



        let rowData = self.wordList[indexPath.row]
        print("\(rowData)")

//        if self.indexPath == 8 || self.indexPath == 9 || self.indexPath == 11 {
//            let cell = tableView.dequeueReusableCell(withReuseIdentifier: String(describing: WordListCellPhoto.self), for: indexPath) as! WordListCellPhoto
//            cell.viewModel = WordListCellPhotoViewModel(content: rowData)
//            return cell
//        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordListCell.self), for: indexPath) as! WordListCell
            cell.viewModel = WordListCellSentenceViewModel(content: rowData)
            return cell
//        }
        
//        return UITableViewCell()

    }


}

extension WordListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        
//        return 300
    }
}
