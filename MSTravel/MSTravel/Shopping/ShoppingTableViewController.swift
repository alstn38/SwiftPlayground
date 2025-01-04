//
//  ShoppingTableViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/4/25.
//

import UIKit

final class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var headerBackgroundView: UIView!
    @IBOutlet var shoppingTextField: UITextField!
    @IBOutlet var shoppingAddButton: UIButton!
    
    private var shoppingArray = ShoppingCategoryInfo().shoppingCategory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupHeaderView()
    }
    
    /// Navigation 설정하는 메서드
    private func setupNavigation() {
        title = "쇼핑"
    }
    
    /// headerVIew를 설정하는 메서드
    private func setupHeaderView() {
        headerBackgroundView.backgroundColor = .systemGray5
        headerBackgroundView.layer.cornerRadius = 10
        
        shoppingTextField.borderStyle = .none
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.textColor = .black
        shoppingTextField.returnKeyType = .done
        
        shoppingAddButton.backgroundColor = .systemGray4
        shoppingAddButton.layer.cornerRadius = 5
        shoppingAddButton.clipsToBounds = true
        shoppingAddButton.setTitle("추가", for: .normal)
        shoppingAddButton.tintColor = .black
    }
}

extension ShoppingTableViewController {
    
    /// TableView의 Section별 row의 개수를 반환하는 메서드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingArray.count
    }
    
    /// TableView의 Section별 Cell을 반환하는 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ShoppingTableViewCell",
            for: indexPath
        ) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(shoppingArray[indexPath.row])
        
        return cell
    }
    
    /// TabieView의 Cell의 height을 반환하는 메서드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
