//
//  WishCategoryViewController.swift
//  MSShopping
//
//  Created by 강민수 on 3/5/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class WishCategoryViewController: UIViewController {
    
    private let viewModel: WishCategoryViewModel
    private let addFolderRelay = PublishRelay<String>()
    private let updateWishCategory = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
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
        
        configureBind()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBind() {
        let input = WishCategoryViewModel.Input(
            addFolder: addFolderRelay.asObservable(),
            cellDidTap: wishCategoryCollectionView.rx.itemSelected.map { $0.row }.asObservable(),
            updateWishCategory: updateWishCategory.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.updateFolder
            .drive(with: self) { owner, folders in
                owner.updateSnapshot(with: folders)
            }
            .disposed(by: disposeBag)
        
        // Q: DiffableDataSourceSnapshot에서 왜 list가 추가된것을 왜 캡쳐에서 알아차리지 못할까?
        // 추론: list는 배열로 이루어져있고 배열의 주소값을 보고 있는 것일까?
        // 배열의 주소값은 C언어에서 [0]번째의 주소값을 보고 있고, list가 append된다고 하더라도 결국 주소값은 변한 것이 없다?
        // 따라서 캡쳐하는 과정에서 이러한 변화를 알아차리지 못하기 때문에 변경하지 않는 것일까??
        output.forceUpdateFolder
            .drive(with: self) { owner, folders in
                owner.wishCategoryCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        output.moveToDetailView
            .drive(with: self) { owner, folder in
                let viewController = owner.createWishListViewController(for: folder)
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.alertError
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
        
        addFolderButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.presentTextAlert()
            }
            .disposed(by: disposeBag)
    }
    
    private func updateSnapshot(with folders: [WishCategory]) {
        var snapshot = NSDiffableDataSourceSnapshot<WishCategoryViewModel.Section, WishCategory>()
        snapshot.appendSections(WishCategoryViewModel.Section.allCases)
        snapshot.appendItems(folders, toSection: .folder)
        dataSource.apply(snapshot)
    }
    
    private func createWishListViewController(for folder: WishCategory) -> UIViewController {
        let viewModel = WishListViewModel(folder: folder)
        viewModel.delegate = self
        return WishListViewController(viewModel: viewModel)
    }
    
    private func presentTextAlert() {
        let alert = UIAlertController(
            title: "폴더 추가",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addTextField()
        
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        
        let addAction = UIAlertAction(
            title: "추가",
            style: .default) { [weak self] _ in
                guard let folderName = alert.textFields?.first?.text else { return }
                self?.addFolderRelay.accept(folderName)
            }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true)
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

extension WishCategoryViewController: WishListViewModelProtocol {
    
    func wishListDidUpdate(_ viewModel: WishListViewModel) {
        updateWishCategory.accept(())
    }
}
