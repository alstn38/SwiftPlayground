//
//  AdvertisementViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import UIKit

final class AdvertisementViewController: UIViewController {
    
    static let identifier: String = "AdvertisementViewController"
    var advertisementText: String?

    @IBOutlet private var advertisementTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        configureView()
    }
    
    /// 데이터를 뷰에 bind하는 메서드
    private func configureView() {
        guard let advertisementText else { return }
        advertisementTitleLabel.text = advertisementText
    }
    
    /// 네비게이션을 설정하는 메서드
    private func setupNavigation() {
        navigationItem.title = "광고 화면"
        
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonDidTap)
        )
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    /// 화면 속성을 정의하는 메서드
    private func setupView() {
        advertisementTitleLabel.font = .boldSystemFont(ofSize: 28)
        advertisementTitleLabel.textColor = .black
        advertisementTitleLabel.numberOfLines = 0
        advertisementTitleLabel.textAlignment = .center
    }
    
    /// 왼쪽 네비게이션 상단 바 버튼을 클릭했을 때 동작하는 메서드
    @objc private func leftBarButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
