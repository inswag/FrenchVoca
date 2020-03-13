//
//  InstitutDetailViewController.swift
//  FrenchVoca
//
//  Created by Insu Park on 2020/03/12.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit
import WebKit

class InstitutDetailViewController: ViewController {
    
    // MARK:- Properties
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    let viewModel: InstitutDetailViewControllerViewModel
    let navigator: Navigator
    
    // MARK:- UI Properties
    
    let customNaviBarTitle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 27)) // 110/27
        let label = UILabel()
        view.addSubview(label)
        label.text = "Institut Français"
        label.textAlignment = .center
        label.font = Tools.font.avenirBook(size: 20)
        label.textColor = Tools.color.lightBlack
        label.numberOfLines = 1
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return view
    }()
    
    lazy var backButton = UIBarButtonItem(title: "Arrière", style: .plain, target: self, action: #selector(backBtn))
    
    @objc func backBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Initialize
    
    init(navigator: Navigator, viewModel: InstitutDetailViewControllerViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    // MARK:- View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNaviBarDesign()
        self.handleWebView()
    }
    
    // MARK:- UI Methods
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    fileprivate func handleWebView() {
        let myURL = URL(string: viewModel.url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    fileprivate func setupNaviBarDesign() {
        self.navigationItem.titleView = customNaviBarTitle
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: Tools.font.avenirBook(size: 20), NSAttributedString.Key.foregroundColor: Tools.color.lightBlack], for: .normal
        )
    }
    
    override func setupUIComponents() {
        self.view.backgroundColor = .white
        [activityIndicator].forEach {
            self.view.addSubview($0)
        }
        activityIndicator.alpha = 1.0
    }
    
    override func setupUILayout() {
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }


}

// MARK:- WKWebview Delegate Methods

extension InstitutDetailViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

