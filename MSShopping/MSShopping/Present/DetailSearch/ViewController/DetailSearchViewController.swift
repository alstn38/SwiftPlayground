//
//  DetailSearchViewController.swift
//  MSShopping
//
//  Created by 강민수 on 2/26/25.
//

import UIKit
import SnapKit
import WebKit

final class DetailSearchViewController: UIViewController {
    
    private let link: String
    private let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    
    init(link: String) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func loadWebView() {
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    private func configureView() {
        view.backgroundColor = .black
    }
    
    private func configureHierarchy() {
        view.addSubview(webView)
    }
    
    private func configureLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
