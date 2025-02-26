//
//  WishListViewController.swift
//  MSShopping
//
//  Created by 강민수 on 2/26/25.
//

import UIKit
import SnapKit

final class WishListViewController: UIViewController {
    
    private let wishListTextField = UITextField()
    private lazy var wishListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var wishListArray: [Wish] = []
    
    private let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Wish> {
        cell, indexPath, itemIdentifier in
        
        var content = UIListContentConfiguration.subtitleCell()
        content.text = itemIdentifier.productName
        content.textProperties.font = .systemFont(ofSize: 14, weight: .medium)
        content.textProperties.color = .white
        
        content.secondaryText = itemIdentifier.date.description
        content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .regular)
        content.secondaryTextProperties.color = .gray
        
        content.textToSecondaryTextVerticalPadding = 4
        
        content.image = UIImage(systemName: "checkmark.square")
        content.imageProperties.tintColor = .yellow
        cell.contentConfiguration = content
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
        backgroundConfig.backgroundColor = .black
        backgroundConfig.cornerRadius = 5
        backgroundConfig.strokeColor = .white
        backgroundConfig.strokeWidth = 1
        cell.backgroundConfiguration = backgroundConfig
    }
    
    private lazy var wishListDataSource = UICollectionViewDiffableDataSource<WishSection, Wish>(
        collectionView: wishListCollectionView,
        cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: self.registration,
                for: indexPath,
                item: itemIdentifier
            )
            
            return cell
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSnapshot()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wishListTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<WishSection, Wish>()
        snapshot.appendSections(WishSection.allCases)
        snapshot.appendItems(wishListArray, toSection: .product)
        wishListDataSource.apply(snapshot)
    }
    
    private func configureView() {
        view.backgroundColor = .black
        wishListTextField.attributedPlaceholder = NSAttributedString(
            string: "위시리스트를 입력해주세요.",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        wishListTextField.returnKeyType = .done
        wishListTextField.textColor = .white
        wishListTextField.delegate = self
        
        wishListCollectionView.backgroundColor = .black
        wishListCollectionView.keyboardDismissMode = .onDrag
        wishListCollectionView.delegate = self
    }
    
    private func configureNavigation() {
        navigationItem.title = "위시리스트 추가"
    }
    
    private func configureHierarchy() {
        view.addSubview(wishListTextField)
        view.addSubview(wishListCollectionView)
    }
    
    private func configureLayout() {
        wishListTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        wishListCollectionView.snp.makeConstraints {
            $0.top.equalTo(wishListTextField.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .black
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}

// MARK: - UICollectionViewDelegate
extension WishListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = wishListDataSource.itemIdentifier(for: indexPath) else { return }
        print("\(item.productName)이 삭제됩니다.")
        
        wishListArray.remove(at: indexPath.item)
        updateSnapshot()
    }
}

// MARK: - UITextFieldDelegate
extension WishListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let productName = textField.text else { return false }
        wishListArray.insert(Wish(productName: productName), at: 0)
        textField.text = nil
        updateSnapshot()
        
        return true
    }
}

// MARK: - WishSection
extension WishListViewController {
    
    enum WishSection: CaseIterable {
        case product
    }
}
