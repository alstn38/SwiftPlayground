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
    private let chatRoomArray: [ChatRoom] = ChatRoom.mockChatList
    private var filteredChatRoomArray: [ChatRoom] = [] {
        didSet {
            talkCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupCollectionView()
        filteredChatRoomArray = chatRoomArray
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
        talkCollectionView.keyboardDismissMode = .onDrag
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return filteredChatRoomArray = chatRoomArray
        }
        
        filteredChatRoomArray = chatRoomArray.filter { $0.isUserIncludedChatRoom(searchText) }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredChatRoomArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TalkCollectionViewCell.identifier,
            for: indexPath
        ) as? TalkCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(filteredChatRoomArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: ChatRoomViewController.identifier
        ) as? ChatRoomViewController else { return }
        viewController.chatRoom = filteredChatRoomArray[indexPath.item]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
