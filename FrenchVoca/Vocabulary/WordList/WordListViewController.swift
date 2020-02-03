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
    let viewModel: WordListViewControllerViewModel
  
//    var wordDAO = WordDAO()
//    var subjectDAO = SubjectDAO()
//    
//    var wordList: [WordVO]!
//    var subjectInfo: [SubjectVO]!
    
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
        tv.register(WordListSentenceCell.self,
                    forCellReuseIdentifier: String(describing: WordListSentenceCell.self))
        tv.register(WordListPhotoCell.self,
                    forCellReuseIdentifier: String(describing: WordListPhotoCell.self))
        return tv
    }()
    
    // MARK:- Initialize
    
    init(navigator: Navigator, viewModel: WordListViewControllerViewModel) {
        self.navigate = navigator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        
        fetchWordList()
//        self.wordList = self.wordDAO.find(subjectCd: indexPath)
//        self.subjectInfo = self.subjectDAO.get(subjectCd: indexPath)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Application.shared.synthesizer.isSpeaking == true {
            Application.shared.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
    // MARK:- UI Method
    
    func setupUIComponents() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        // UI Layouts

        [tableView, popImageButton, popTextButton, optionButton].forEach {
            self.view.addSubview($0)
        }

        tableView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.bottom.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
        }
        
        popImageButton.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            m.leading.equalToSuperview().offset(20)
            m.width.equalTo(12)
            m.height.equalTo(20.5)
        }
        
        popTextButton.snp.makeConstraints { (m) in
            m.leading.equalTo(popImageButton.snp.trailing).offset(5)
            m.centerY.equalTo(popImageButton.snp.centerY)
        }
        
        optionButton.snp.makeConstraints { (m) in
            m.trailing.equalToSuperview().offset(-20)
            m.width.equalTo(35)
            m.height.equalTo(35)
            m.centerY.equalTo(popImageButton.snp.centerY)
        }
    }

    // MARK:- DAO Methods
    
    func fetchWordList() {
        let id = viewModel.id
        viewModel.fetchSelectedSubject(id: id)
        viewModel.fetchSelectedWords(id: id)
    }

    
}

extension WordListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let wordList = self.viewModel.wordList else { return 10 }
        return wordList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let rowData = self.viewModel.wordList?[indexPath.row] else { return UITableViewCell() }
        
        switch viewModel.id {
        case 8, 9, 11:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordListPhotoCell.self), for: indexPath) as! WordListPhotoCell
            cell.viewModel = WordListPhotoCellViewModel(content: rowData)
            cell.wordOrderLabel.text = "Numéro \(indexPath.row + 1)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordListSentenceCell.self), for: indexPath) as! WordListSentenceCell
            cell.viewModel = WordListSentenceCellViewModel(content: rowData)
            cell.wordOrderLabel.text = "Numéro \(indexPath.row + 1)"
            return cell
        }
        
        

    }


}

extension WordListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        
//        return 300
    }
}
