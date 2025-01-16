//
//  ProductCollectionViewCell.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import SnapKit
import Kingfisher
import UIKit

final class ProductCollectionViewCell: BaseCollectionViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mallNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    func configureCell(_ item: Item) {
        let imageURL = URL(string: item.image)
        productImageView.kf.setImage(with: imageURL)
        mallNameLabel.text = item.mallName
        let price = Int(item.lowPrice) ?? 0
        productPriceLabel.text = price.formatted() + "원"
        productNameLabel.text = item.title.replacingOccurrences(
            of: "<[^>]+>|&quot;",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }
    
    override func setupCell() {
        setupHierarchy()
        setupLayout()
    }
    
    override func setupHierarchy() {
        [productImageView, mallNameLabel, productNameLabel, productPriceLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setupLayout() {
        productImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(productImageView.snp.width)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        productPriceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
