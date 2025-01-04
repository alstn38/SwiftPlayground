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
    
    private var shoppingArray = ShoppingCategoryInfo().shoppingCategory {
        didSet {
            tableView.reloadData()
        }
    }
    
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
    
    /// 쇼핑 목록을 swipe를 통해 삭제하려고 시도할 때 동작하는 메서드
    private func presentDeleteAlert(at indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "정말 삭제하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        
        let deleteAction = UIAlertAction(
            title: "삭제",
            style: .destructive,
            handler: { [weak self] _ in
                self?.shoppingArray.remove(at: indexPath.row)
            }
        )
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
    
    /// 쇼핑 목록 추가 버튼을 눌렀을 때 동작하는 메서드
    @IBAction private func shoppingAddButtonDidTap(_ sender: Any) {
        let userInputText = shoppingTextField.text ?? ""
        guard !userInputText.isEmpty else { return }
        
        let newShoppingCategory = ShoppingCategory(title: userInputText)
        shoppingArray.append(newShoppingCategory)
        view.endEditing(true)
    }
    
    /// 쇼핑 목록 키보드 완료 버튼을 눌렀을 때 동작하는 메서드
    @IBAction func shoppingTextFieldRetunDidTap(_ sender: UITextField) {
        shoppingAddButtonDidTap(sender)
    }
    
    // objc func에 enum타입을 넣어 두 가지 버튼을 동시에 하려고 했지만 실패
    // -> objc에는 enum은 지원하지 않는 것으로 배웠다.
    /// 구매완료 버튼을 클릭했을 때 동작하는 메서드입니다.
    @objc private func shoppingCheckButtonDidTap(_ sender: UIButton) {
        shoppingArray[sender.tag].toggleState(.isChecked)
    }
    
    /// 즐겨찾기 버튼을 클릭했을 때 동작하는 메서드입니다.
    @objc private func shoppingLikeButtonDidTap(_ sender: UIButton) {
        shoppingArray[sender.tag].toggleState(.isLiked)
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
        
        cell.configureCell(shoppingArray[indexPath.row], tag: indexPath.row)
        cell.shoppingCheckButton.addTarget(self, action: #selector(shoppingCheckButtonDidTap), for: .touchUpInside)
        cell.shoppingLikeButton.addTarget(self, action: #selector(shoppingLikeButtonDidTap), for: .touchUpInside)
        
        return cell
    }
    
    /// TabieView의 Cell의 height을 반환하는 메서드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /// TableView 밀어서 삭제하는 메서드
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            presentDeleteAlert(at: indexPath)
        }
    }
}
