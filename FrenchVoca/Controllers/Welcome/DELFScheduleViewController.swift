//
//  DELFScheduleViewController.swift
//  FrenchVoca
//
//  Created by 박인수 on 24/01/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import WebKit

class DELFScheduleViewController: UIViewController {
    
    // MARK:- Custom Navigation Bar
    let customNaviBarTitle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 27)) // 110/27
        let label = UILabel()
        view.addSubview(label)
        label.text = "French Voca"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Book", size: 20)
        label.textColor = UIColor.rgb(red: 74, green: 74, blue: 74)
        label.numberOfLines = 1
        label.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        return view
    }()
    
    lazy var backButton = UIBarButtonItem(title: "Arrière", style: .plain, target: self, action: #selector(backBtn))
    
    @objc func backBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- WebView & Activity Indicator
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    fileprivate func handleWebView() {
        let myURL = URL(string: "http://www.delf-dalf.co.kr/examens/sessions.php")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNaviBarDesign()
        self.setupAIDesign() // AI = Activity Indicator
        self.handleWebView()
    }
    
    // MARK:- UI Design
    fileprivate func setupNaviBarDesign() {
        self.navigationItem.titleView = customNaviBarTitle
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 74, green: 74, blue: 74)], for: .normal
        )
    }
    
    fileprivate func setupAIDesign() {
        activityIndicator.alpha = 1.0
        view.addSubview(activityIndicator)
        activityIndicator.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        activityIndicator.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicator.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

}

//MARK:- WKWebview Delegate Methods
extension DELFScheduleViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
