//
//  NasaViewController.swift
//  MSUniverse
//
//  Created by 강민수 on 2/11/25.
//

import UIKit
import SnapKit

final class NasaViewController: UIViewController {
    
    private let viewModel: NasaViewModel
    private let input: NasaViewModel.Input
    private let progressLabel = UILabel()
    private let progressView = UIProgressView()
    private let nasaImageView = UIImageView()
    
    init(viewModel: NasaViewModel) {
        self.viewModel = viewModel
        self.input = NasaViewModel.Input(requestButtonDidTap: Observable(()))
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBind() {
        let output = viewModel.transform(from: input)
        
        output.requestButtonState.bind { [weak self] state in
            guard let self else { return }
            navigationItem.rightBarButtonItem?.isEnabled = state
        }
        
        output.progressViewHidden.bind { [weak self] isHidden in
            guard let self else { return }
            progressView.isHidden = isHidden
        }
        
        output.universeImage.bind { [weak self] imageData in
            guard let self else { return }
            
            if let imageData {
                let image = UIImage(data: imageData)
                nasaImageView.image = image
            } else {
                nasaImageView.image = UIImage(systemName: "exclamationmark.arrow.trianglehead.counterclockwise.rotate.90")
            }
        }
        
        output.progressLabelText.bind { [weak self] text in
            guard let self else { return }
            progressLabel.text = text
        }
        
        output.progressValue.bind { [weak self] progress in
            guard let self else { return }
            changeProgressView(progress)
        }
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
        progressView.isHidden = true
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
        input.requestButtonDidTap.send(())
    }
    
    private func changeProgressView(_ progress: Float) {
        UIView.animate(withDuration: 0.1) {
            self.progressView.progress = progress
        }
    }
}
