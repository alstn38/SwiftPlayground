//
//  WishListViewController.swift
//  MSShopping
//
//  Created by 강민수 on 2/26/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class WishListViewController: UIViewController {
    
    private let viewModel: WishListViewModel
    private let disposeBag = DisposeBag()
    private let wishListTextField = UITextField()
    private lazy var wishListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private let registration = UICollectionView.CellRegistration<UICollectionViewListCell, WishList> {
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
    
    private lazy var wishListDataSource = UICollectionViewDiffableDataSource<WishListViewModel.Section, WishList>(
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
    
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
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
    
    private func configureBind() {
        let input = WishListViewModel.Input(
            addWishList: wishListTextField.rx.controlEvent(.editingDidEndOnExit)
                .withLatestFrom(wishListTextField.rx.text.orEmpty).asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.folderName
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.updateWishList
            .drive(with: self) { owner, wishList in
                owner.updateSnapshot(with: wishList)
            }
            .disposed(by: disposeBag)
        
        output.alertError
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateSnapshot(with wishList: [WishList]) {
        var snapshot = NSDiffableDataSourceSnapshot<WishListViewModel.Section, WishList>()
        snapshot.appendSections(WishListViewModel.Section.allCases)
        snapshot.appendItems(wishList, toSection: .product)
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
        
        wishListCollectionView.backgroundColor = .black
        wishListCollectionView.keyboardDismissMode = .onDrag
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
