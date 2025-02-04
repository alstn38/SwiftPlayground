//
//  PhotoCollectionViewCell.swift
//  MSMap
//
//  Created by 강민수 on 2/4/25.
//

import SnapKit
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setupConstraints()
    }
    
    func setUI(_ image: UIImage) {
        photoImageView.image = image
    }
    
    private func setUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
