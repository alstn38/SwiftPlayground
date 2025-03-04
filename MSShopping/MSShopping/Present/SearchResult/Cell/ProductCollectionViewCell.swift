//
//  ProductCollectionViewCell.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import SnapKit
import Kingfisher
import RxSwift
import UIKit

final class ProductCollectionViewCell: BaseCollectionViewCell {
    
    var disposeBag = DisposeBag()
    
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
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configureCell(_ item: ProductEntity) {
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
        
        let favoriteImage = item.favorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    override func setupCell() {
        setupHierarchy()
        setupLayout()
    }
    
    override func setupHierarchy() {
        [productImageView, mallNameLabel, productNameLabel, productPriceLabel, favoriteButton].forEach {
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
        
        favoriteButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(productImageView).inset(10)
            $0.size.equalTo(30)
        }
    }
}
