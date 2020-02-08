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
    var viewModel: WordListViewControllerViewModel
    
    
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
        let tv = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Application.shared.synthesizer.isSpeaking == true {
            Application.shared.synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.view.frame.width,
                                        height: 260))
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var menuImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: self.view.frame.width,
                                                  height: 260))
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let koreanTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "주제"
        label.textAlignment = .left
        label.font = Tools.font.appleSDGothicNeoBold(size: 25)
        label.textColor = UIColor.rgb(r: 255, g: 255, b: 255)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subFrenchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sujet français"
        label.textAlignment = .left
        label.font = Tools.font.avenirMedium(size: 18)
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subSentenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Citation / Proverbe française"
        label.textAlignment = .left
        label.font = Tools.font.avenirLight(size: 18)
        label.textColor = UIColor.white
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK:- UI Method
    
    func setupUIComponents() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        // UI Layouts
        
        // TableView Header
        
        [menuImageView].forEach {
            self.headerView.addSubview($0)
        }

        [koreanTitleLabel, subFrenchTitleLabel, subSentenceLabel].forEach {
            self.headerView.addSubview($0)
        }

        menuImageView.snp.makeConstraints { (m) in
            m.top.bottom.leading.trailing.equalToSuperview()
        }

        subSentenceLabel.snp.makeConstraints { (m) in
            m.leading.equalTo(headerView.snp.leading).offset(20)
            m.bottom.equalTo(headerView.snp.bottom).offset(-20)
            m.trailing.equalTo(headerView.snp.trailing)
        }

        subFrenchTitleLabel.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(20)
            m.bottom.equalTo(subSentenceLabel.snp.top)
            m.trailing.equalToSuperview().offset(-20)
        }

        koreanTitleLabel.snp.makeConstraints { (m) in
//            m.top.equalToSuperview().offset(50)
            m.leading.equalToSuperview().offset(20)
            m.bottom.equalTo(subFrenchTitleLabel.snp.top)
            m.trailing.equalToSuperview().offset(-20)
        }
        
        // TableView Cell
        
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
        
        setupSubjectUI()
    }
    
    // 이거 별로 좋지 않은 것 같음 따로 처리할 방법을 찾아보자
    func setupSubjectUI() {
        guard let subject = viewModel.subjectInfo else { return }
        menuImageView.image = UIImage(named: subject.subjectFrenchTitle)
        koreanTitleLabel.text = subject.subjectKoreanTitle
        subFrenchTitleLabel.text = subject.subjectFrenchTitle
        subSentenceLabel.text = subject.subjectSentence
    }

    
}

// MARK:- Table View Data Source Methods

extension WordListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = self.viewModel.wordList[indexPath.row]
        
        switch viewModel.id {
        case 8, 9, 11:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordListPhotoCell.self),
                                                     for: indexPath) as! WordListPhotoCell
            cell.viewModel = WordListPhotoCellViewModel(content: rowData)
            cell.wordOrderLabel.text = "Numéro \(indexPath.row + 1)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WordListSentenceCell.self),
                                                     for: indexPath) as! WordListSentenceCell
            cell.viewModel = WordListSentenceCellViewModel(content: rowData)
            cell.wordOrderLabel.text = "Numéro \(indexPath.row + 1)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }


}

// MARK:- Table View Delegate Methods

extension WordListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 260
    }
    
}
