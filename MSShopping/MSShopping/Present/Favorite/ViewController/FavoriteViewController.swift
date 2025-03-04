//
//  FavoriteViewController.swift
//  MSShopping
//
//  Created by 강민수 on 3/4/25.
//

import UIKit
import SnapKit

final class FavoriteViewController: UIViewController {
    
    private let viewModel: FavoriteViewModel
    private let searchTextField = UITextField()
    private lazy var favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
    
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
            return cell
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<FavoriteViewModel.Section, FavoriteProduct>()
        snapshot.appendSections(FavoriteViewModel.Section.allCases)
        snapshot.appendItems(viewModel.favoriteProduct, toSection: .favorite)
        dataSource.apply(snapshot)
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
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalWidth(0.7)
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
