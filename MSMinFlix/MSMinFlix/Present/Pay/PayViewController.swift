//
//  PayViewController.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import SnapKit
import UIKit

final class PayViewController: UIViewController {
    
    private let paySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["멤버십", "현장결제", "쿠폰"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .gray
        segmentedControl.setTitleTextAttributes(
            [.font : UIFont.systemFont(ofSize: 16, weight: .bold),
             .foregroundColor: UIColor.white],
            for: .normal
        )
        segmentedControl.setTitleTextAttributes(
            [.font : UIFont.systemFont(ofSize: 16, weight: .bold),
             .foregroundColor: UIColor.white],
            for: .selected
        )
        segmentedControl.layer.cornerRadius = 10
        
        return segmentedControl
    }()
    
    private let payView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let payImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .naverLogo)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let localeButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        var attributedString = AttributedString(
            "국내",
            attributes: AttributeContainer([.foregroundColor: UIColor.gray])
        )
        configuration.attributedTitle = attributedString
        
        let buttonImage = UIImage(systemName: "arrowshape.down.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        configuration.image = buttonImage
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.imagePadding = 5
        configuration.imagePlacement = .trailing
        configuration.image?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        
        return button
    }()
    
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .lockIMage)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .greenCheck)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "바로 결제 사용하기"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        [
            paySegmentedControl, payView, payImageView,
            localeButton, deleteButton, lockImageView,
            guideLabel, checkImageView, checkLabel,
            checkButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        paySegmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(40)
        }
    }
}
