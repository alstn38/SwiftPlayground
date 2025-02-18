//
//  ViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let titles: [String] = [
        "1. SimpleTableViewController",
        "2. NumbersViewController"
    ]
    
    private lazy var items = Observable.just(titles)
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    private func configureTableView() {
        items
            .bind(to: mainTableView.rx.items(
                cellIdentifier: "UITableViewCell",
                cellType: UITableViewCell.self
            )) { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        mainTableView.rx
            .itemSelected
            .withUnretained(self)
            .map { $0.0.getViewController(at: $0.1.item) }
            .bind(with: self) { owner, viewController in
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        navigationItem.title = "MS RxSwift World"
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubview(mainTableView)
    }
    
    private func configureLayout() {
        mainTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getViewController(at index: Int) -> UIViewController {
        switch index {
        case 0:
            return SimpleTableViewController()
        case 1:
            return NumbersViewController()
        default:
            return UIViewController()
        }
    }
}
