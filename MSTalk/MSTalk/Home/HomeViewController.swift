//
//  ViewController.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private var friendSearchBar: UISearchBar!
    @IBOutlet private var talkCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupCollectionView()
    }
    
    private func setupNavigation() {
        navigationItem.title = "MS TALK"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        friendSearchBar.delegate = self
        friendSearchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    private func setupCollectionView() {
        talkCollectionView.delegate = self
        talkCollectionView.dataSource = self
        
        let uiNib = UINib(nibName: TalkCollectionViewCell.identifier, bundle: nil)
        talkCollectionView.register(uiNib, forCellWithReuseIdentifier: TalkCollectionViewCell.identifier)
        
        let screenWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: screenWidth, height: 80)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        talkCollectionView.collectionViewLayout = layout
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TalkCollectionViewCell.identifier,
            for: indexPath
        ) as? TalkCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
