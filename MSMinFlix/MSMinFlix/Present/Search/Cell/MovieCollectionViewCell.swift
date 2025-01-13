//
//  MovieCollectionViewCell.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import SnapKit
import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    private let numberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    private let movieStartDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        [numberView, numberLabel, movieTitleLabel, movieStartDate].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        numberView.snp.makeConstraints {
            $0.centerY.leading.equalTo(contentView)
            $0.height.equalTo(30)
            $0.width.equalTo(40)
        }
        
        numberLabel.snp.makeConstraints {
            $0.center.equalTo(numberView)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(numberView.snp.trailing).offset(15)
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(movieStartDate.snp.leading).offset(-15)
        }
        
        movieStartDate.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
