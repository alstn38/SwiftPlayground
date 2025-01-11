//
//  ChatRoomViewController.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

final class ChatRoomViewController: UIViewController {

    var chatRoom: ChatRoom?
    @IBOutlet private var chatTableView: UITableView!
    @IBOutlet private var textViewBackgroundView: UIView!
    @IBOutlet private var textViewPlaceholderLabel: UILabel!
    @IBOutlet private var chatTextView: UITextView!
    @IBOutlet private var chatSendButton: UIButton!
    private var chatArray: [Chat] = [] {
        didSet {
            chatTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        configureView()
        setupTableView()
    }
    
    private func setupNavigation() {
        guard let chatRoom else { return }
        navigationItem.title = chatRoom.chatroomName
    }
    
    private func configureView() {
        guard let chatRoom else { return }
        chatArray = chatRoom.chatList
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        textViewBackgroundView.backgroundColor = .systemGray6
        textViewBackgroundView.layer.cornerRadius = 5
        
        textViewPlaceholderLabel.text = "메세지를 입력하세요"
        textViewPlaceholderLabel.textColor = .lightGray
        textViewPlaceholderLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        chatTextView.delegate = self
        chatTextView.font = .systemFont(ofSize: 12, weight: .regular)
        chatTextView.backgroundColor = .clear
        chatTextView.showsVerticalScrollIndicator = false
        chatTextView.showsHorizontalScrollIndicator = false
        
        chatSendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        chatSendButton.tintColor = .lightGray
    }
    
    private func setupTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.showsVerticalScrollIndicator = false
        
        let senderTableViewCellNib = UINib(nibName: SenderTableViewCell.identifier, bundle: nil)
        chatTableView.register(senderTableViewCellNib, forCellReuseIdentifier: SenderTableViewCell.identifier)
        
        let receiverTableViewCellNib = UINib(nibName: ReceiverTableViewCell.identifier, bundle: nil)
        chatTableView.register(receiverTableViewCellNib, forCellReuseIdentifier: ReceiverTableViewCell.identifier)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatMessage = chatArray[indexPath.row]
        let isSenderChat: Bool = chatMessage.user == .user
        let identifier: String = isSenderChat ? SenderTableViewCell.identifier : ReceiverTableViewCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        ) as? ChatCellConfigurable else { return UITableViewCell() }
        
        cell.configureChatCell(chatMessage)
        
        return cell
    }
}

// MARK: - UITextViewDelegate
extension ChatRoomViewController: UITextViewDelegate {
    
}

// MARK: - ReusableViewProtocol
extension ChatRoomViewController: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
