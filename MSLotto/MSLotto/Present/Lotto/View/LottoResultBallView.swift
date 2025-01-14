//
//  LottoResultBallView.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

import SnapKit
import UIKit

final class LottoResultBallView: UIView {
    
    private let numberBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let lottoNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        numberBackgroundView.backgroundColor = backgroundColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func configureView(_ text: String) {
        lottoNumberLabel.text = text
    }
    
    private func setupView() {
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        addSubview(numberBackgroundView)
        addSubview(lottoNumberLabel)
    }
    
    private func setupLayout() {
        numberBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lottoNumberLabel.snp.makeConstraints {
            $0.center.equalTo(numberBackgroundView)
        }
    }
}
