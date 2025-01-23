//
//  TapAnimationLabel.swift
//  MSValueTransfer
//
//  Created by 강민수 on 1/23/25.
//

import UIKit

final class TapAnimationLabel: UILabel {
    
    private let labelText: String
    
    init(text: String) {
        self.labelText = text
        super.init(frame: .zero)
        
        configureLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    private func configureLabel() {
        self.text = "\n   \(labelText)   \n"
        self.font = .systemFont(ofSize: 24, weight: .bold)
        self.textAlignment = .center
        self.numberOfLines = 3
        self.textColor = .black
        self.isUserInteractionEnabled = true
    }
}
