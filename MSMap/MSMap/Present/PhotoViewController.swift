//
//  PhotoViewController.swift
//  MSMap
//
//  Created by 강민수 on 2/4/25.
//

import PhotosUI
import UIKit

final class PhotoViewController: UIViewController {
    
    private var photoImageArray: [UIImage] = [] {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    
    private lazy var photoCollectionView: UICollectionView = {
        let spacing: CGFloat = 10
        let width: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let itemSize: CGFloat = floor((width - spacing * 4) / 3)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupUI()
        setupConstraints()
    }
    
    private func setupNavigation() {
        let albumButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(albumButtonTapped))
        
        navigationItem.rightBarButtonItem = albumButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(photoCollectionView)
    }
    
    private func setupConstraints() {
        photoCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func albumButtonTapped(_ sender: UIBarButtonItem) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 20

        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        
        present(pickerViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - PHPickerViewControllerDelegate
extension PhotoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function)
    }
}
