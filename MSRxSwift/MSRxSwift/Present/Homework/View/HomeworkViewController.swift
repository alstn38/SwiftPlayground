//
//  HomeworkViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HomeworkViewController: UIViewController {
    
    private let viewModel: HomeworkViewModel
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        configureView()
    }
    
    init(viewModel: HomeworkViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
          
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
