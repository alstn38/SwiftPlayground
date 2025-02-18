//
//  SimpleTableViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureView()
        configureHierarchy()
        configureLayout()
    }

    private func configureTableView() {
        let items = Observable.just(
            (0..<20).map { String($0) }
        )
        
        items
            .bind(to: tableView.rx.items(
                cellIdentifier: "UITableViewCell",
                cellType: UITableViewCell.self
            )) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                let alertView = UIAlertController(
                    title: "RxExample",
                    message: "Tapped \(value)",
                    preferredStyle: .alert
                )
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
                owner.present(alertView, animated: true)
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(with: self) { owner, indexPath in
                let alertView = UIAlertController(
                    title: "RxExample",
                    message: "Tapped Detail @ \(indexPath.section),\(indexPath.row)",
                    preferredStyle: .alert
                )
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
                owner.present(alertView, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
