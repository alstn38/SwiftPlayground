//
//  HomeworkViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class HomeworkViewController: UIViewController {
    
    private let viewModel: HomeworkViewModel
    private let input: HomeworkViewModel.Input
    private let disposeBag = DisposeBag()
    private let viewDidLoadRelay: PublishRelay<Void> = PublishRelay()
    private let detailButtonDidTapRelay: PublishRelay<Int> = PublishRelay()
    
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
    
    init(viewModel: HomeworkViewModel) {
        self.viewModel = viewModel
        self.input = HomeworkViewModel.Input(
            viewDidLoad: viewDidLoadRelay.asObservable(),
            searchTextDidChange: searchBar.rx.searchButtonClicked.withLatestFrom(searchBar.rx.text.orEmpty).asObservable(),
            personItemDidTap: tableView.rx.modelSelected(Person.self).asObservable(),
            detailButtonDidTap: detailButtonDidTapRelay.asObservable()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        configureView()
        viewDidLoadRelay.accept(())
    }
    
    private func bind() {
        let output = viewModel.transform(from: input)
        
        output.updatePersonData
            .bind(to: tableView.rx.items(
                cellIdentifier: PersonTableViewCell.identifier,
                cellType: PersonTableViewCell.self
            )) { (row, element, cell) in
                cell.configureView(element)
                
                cell.detailButton.rx.tap
                    .map { row }
                    .bind(with: self) { owner, index in
                        owner.detailButtonDidTapRelay.accept(index)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.updateRecentSearchData
            .bind(to: collectionView.rx.items(
                cellIdentifier: UserCollectionViewCell.identifier,
                cellType: UserCollectionViewCell.self
            )) { (row, element, cell) in
                cell.configureView(element)
            }
            .disposed(by: disposeBag)
        
        output.moveToDetailView
            .bind(with: self) { owner, person in
                owner.navigationController?.pushViewController(DetailViewController(person: person), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(
            UserCollectionViewCell.self,
            forCellWithReuseIdentifier: UserCollectionViewCell.identifier
        )
        
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        tableView.register(
            PersonTableViewCell.self,
            forCellReuseIdentifier: PersonTableViewCell.identifier
        )
        tableView.backgroundColor = .white
        tableView.rowHeight = 100
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
