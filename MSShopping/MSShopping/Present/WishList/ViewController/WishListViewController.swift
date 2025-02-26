//
//  WishListViewController.swift
//  MSShopping
//
//  Created by 강민수 on 2/26/25.
//

import UIKit
import SnapKit

final class WishListViewController: UIViewController {
    
    private let wishListTextField = UITextField()
    private lazy var wishListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wishListTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureView() {
        view.backgroundColor = .black
        wishListTextField.attributedPlaceholder = NSAttributedString(
            string: "위시리스트를 입력해주세요.",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        wishListTextField.returnKeyType = .done
        wishListTextField.textColor = .white
        wishListCollectionView.backgroundColor = .black
    }
    
    private func configureNavigation() {
        navigationItem.title = "위시리스트 추가"
    }
    
    private func configureHierarchy() {
        view.addSubview(wishListTextField)
        view.addSubview(wishListCollectionView)
    }
    
    private func configureLayout() {
        wishListTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        wishListCollectionView.snp.makeConstraints {
            $0.top.equalTo(wishListTextField.snp.bottom).offset(5)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        configuration.backgroundColor = .black
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
