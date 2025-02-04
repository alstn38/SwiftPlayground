//
//  PhotoViewController.swift
//  MSMap
//
//  Created by 강민수 on 2/4/25.
//

import PhotosUI
import UIKit

protocol PhotoViewControllerDelegate: AnyObject {
    func photoViewController(_ viewController: UIViewController, didSelectedItemImage: UIImage)
}

final class PhotoViewController: UIViewController {
    
    weak var delegate: PhotoViewControllerDelegate?
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .gray
        return activityIndicatorView
    }()
    
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
        [photoCollectionView, activityIndicatorView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        
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
        
        cell.setUI(photoImageArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = photoImageArray[indexPath.item]
        delegate?.photoViewController(self, didSelectedItemImage: selectedImage)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate
extension PhotoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        activityIndicatorView.startAnimating()
        let itemProviderArray = results.map { $0.itemProvider }
        
        guard itemProviderArray.allSatisfy({ $0.canLoadObject(ofClass: UIImage.self) }) else {
            dismiss(animated: true) {
                self.presentWarningAlert(title: "사진 오류", message: "선택된 사진에서 가져올 수 없는 사진이 있습니다.")
            }
            return
        }
        
        let dispatchGroup = DispatchGroup()
        var newImageArray: [UIImage] = []
        for provider in itemProviderArray {
            dispatchGroup.enter()
            
            provider.loadObject(ofClass: UIImage.self) { image, error in
                if let image = image as? UIImage {
                    newImageArray.append(image)
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            guard newImageArray.count == results.count else {
                self.presentWarningAlert(title: "사진 오류", message: "선택된 사진을 가져오는데 실패했습니다.")
                return
            }
            
            self.photoImageArray = newImageArray
            self.activityIndicatorView.stopAnimating()
        }
        
        dismiss(animated: true)
    }
}
