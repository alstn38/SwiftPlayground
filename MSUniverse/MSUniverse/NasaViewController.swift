//
//  NasaViewController.swift
//  MSUniverse
//
//  Created by 강민수 on 2/11/25.
//

import UIKit
import SnapKit

final class NasaViewController: UIViewController {
    
    private let progressLabel = UILabel()
    private let progressView = UIProgressView()
    private let nasaImageView = UIImageView()
    
    private var total: Double = 0.0
    private var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = String(format: "%.2f", result * 100) + " / 100"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    func configureNavigation() {
        let requestButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(requestButtonClicked)
        )
        
        navigationItem.title = "우주를 줄게🪐"
        navigationItem.rightBarButtonItem = requestButton
    }
    
    func configureView() {
        view.backgroundColor = .black
        progressView.progressTintColor = .systemBlue
        progressLabel.textColor = .white
        progressLabel.textAlignment = .center
    }
    
    func configureHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressView)
        view.addSubview(progressLabel)
    }
    
    func configureLayout() {
        nasaImageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(2)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func requestButtonClicked() {
        buffer = Data()
    }
}
