//
//  LottoResultBallView.swift
//  MSLotto
//
//  Created by 강민수 on 1/14/25.
//

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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView(_ text: String) {
        lottoNumberLabel.text = text
    }
}
