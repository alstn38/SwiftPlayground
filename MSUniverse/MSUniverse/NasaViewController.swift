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
            changeProgressView(Float(result))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureNavigation() {
        let requestButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(requestButtonClicked)
        )
        
        navigationItem.title = "우주를 줄게 🪐"
        navigationItem.rightBarButtonItem = requestButton
    }
    
    private func configureView() {
        view.backgroundColor = .black
        progressView.progressTintColor = .systemBlue
        progressLabel.textColor = .white
        progressLabel.textAlignment = .center
    }
    
    private func configureHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressView)
        view.addSubview(progressLabel)
    }
    
    private func configureLayout() {
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
    
    @objc private func requestButtonClicked() {
        fetchUniversePicture()
    }
    
    private func fetchUniversePicture() {
        let request = URLRequest(url: UniversePicture.photo, timeoutInterval: 7)
        let configuration = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main
        )
        configuration.dataTask(with: request).resume()
    }
    
    private func changeProgressView(_ progress: Float) {
        UIView.animate(withDuration: 0.1) {
            self.progressView.progress = progress
        }
    }
}

// MARK: - URLSessionDataDelegate
extension NasaViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        guard let response = response as? HTTPURLResponse,
              let contentLength = response.value(forHTTPHeaderField: "Content-Length"),
              let contentLength = Double(contentLength)
        else {
            return .cancel
        }
        
        progressView.isHidden = false
        buffer = Data()
        total = contentLength
        navigationItem.rightBarButtonItem?.isEnabled = false
        return .allow
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error {
            progressLabel.text = "사진을 가져오는데 문제가 발생했습니다. - \(error)"
            nasaImageView.image = UIImage(systemName: "exclamationmark.arrow.trianglehead.counterclockwise.rotate.90")
            return
        }
        
        guard let buffer else {
            progressLabel.text = "사진을 가져오는데 문제가 발생했습니다."
            return
        }
        
        let image = UIImage(data: buffer)
        nasaImageView.image = image
        progressLabel.text = nil
        progressView.isHidden = true
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
