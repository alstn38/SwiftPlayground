//
//  FavoriteViewController.swift
//  MSShopping
//
//  Created by 강민수 on 3/4/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FavoriteViewController: UIViewController {
    
    private let viewModel: FavoriteViewModel
    private let searchTextField = UITextField()
    private lazy var favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
    private let favoriteButtonDidTapRelay = PublishRelay<ProductEntity>()
    private let updateSnapShotRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    private let registration = UICollectionView.CellRegistration<ProductCollectionViewCell, FavoriteProduct> {
        cell, indexPath, itemIdentifier in
        
        let item = itemIdentifier.toEntity()
        cell.configureCell(item)
    }
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<FavoriteViewModel.Section, FavoriteProduct>(
        collectionView: favoriteCollectionView,
        cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: self.registration,
                for: indexPath,
                item: itemIdentifier
            )
            
            cell.favoriteButton.rx.tap
                .map { itemIdentifier.toEntity() }
                .bind(to: favoriteButtonDidTapRelay)
                .disposed(by: cell.disposeBag)
            
            return cell
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBind() {
        let input = FavoriteViewModel.Input(
            viewDidLoad: Observable.just(()),
            searchTextDidChange: searchTextField.rx.text.orEmpty.asObservable(),
            cellFavoriteDidTap: favoriteButtonDidTapRelay.asObservable(),
            updateSnapShot: updateSnapShotRelay.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.updateFavoriteProduct
            .drive(with: self) { owner, product in
                owner.updateSnapshot(with: product)
            }
            .disposed(by: disposeBag)
        
        output.alertError
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateSnapshot(with product: [FavoriteProduct]) {
        var snapshot = NSDiffableDataSourceSnapshot<FavoriteViewModel.Section, FavoriteProduct>()
        snapshot.appendSections(FavoriteViewModel.Section.allCases)
        snapshot.appendItems(product, toSection: .favorite)
        dataSource.apply(snapshot)
        updateSnapShotRelay.accept(())
    }
    
    private func configureNavigation() {
        navigationItem.title = "나의 즐겨찾기"
    }
    
    private func configureView() {
        view.backgroundColor = .black
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "찾고싶은 즐겨찾기를 입력해주세요.",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        searchTextField.returnKeyType = .search
        searchTextField.textColor = .white
        
        favoriteCollectionView.backgroundColor = .black
        favoriteCollectionView.keyboardDismissMode = .onDrag
    }
    
    private func configureHierarchy() {
        [searchTextField, favoriteCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        favoriteCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1 / 2 * 1.4)
        )

        let groupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)

        let layout = UICollectionViewCompositionalLayout(section: sectionLayout)
        return layout
    }
}

