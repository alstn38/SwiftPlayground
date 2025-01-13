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
            paySegmentedControl
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
