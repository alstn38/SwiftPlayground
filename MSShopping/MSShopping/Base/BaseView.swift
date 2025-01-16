//
//  BaseView.swift
//  MSShopping
//
//  Created by 강민수 on 1/16/25.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() { }
    
    func setupHierarchy() { }
    
    func setupLayout() { }
}
