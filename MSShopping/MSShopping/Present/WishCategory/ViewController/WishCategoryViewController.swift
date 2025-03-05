//
//  WishCategoryViewController.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import UIKit
import SnapKit

final class WishCategoryViewController: UIViewController {
    
    private let viewModel: WishCategoryViewModel
    private let addFolderButton = UIBarButtonItem()
    private lazy var wishCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
    
    private let registration = UICollectionView.CellRegistration<WishCategoryCollectionViewCell, WishCategory> {
        cell, indexPath, itemIdentifier in
        cell.configureCell(itemIdentifier)
    }
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<WishCategoryViewModel.Section, WishCategory>(
        collectionView: wishCategoryCollectionView,
        cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: self.registration,
                for: indexPath,
                item: itemIdentifier
            )
            // TODO: cell 클릭 bind 추가
            return cell
        }
    )
    
    init(viewModel: WishCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func updateSnapshot(with product: [WishCategory]) {
        var snapshot = NSDiffableDataSourceSnapshot<WishCategoryViewModel.Section, WishCategory>()
        snapshot.appendSections(WishCategoryViewModel.Section.allCases)
        snapshot.appendItems(product, toSection: .folder)
        dataSource.apply(snapshot)
    }
    
    private func configureNavigation() {
        navigationItem.title = "나의 위시리스트 선택하기"
        addFolderButton.image = UIImage(systemName: "plus")
        addFolderButton.style = .plain
        navigationItem.rightBarButtonItem = addFolderButton
    }
    
    private func configureView() {
        view.backgroundColor = .black
        wishCategoryCollectionView.backgroundColor = .black
    }
    
    private func configureHierarchy() {
        view.addSubview(wishCategoryCollectionView)
    }
    
    private func configureLayout() {
        wishCategoryCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
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
            heightDimension: .absolute(80)
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
