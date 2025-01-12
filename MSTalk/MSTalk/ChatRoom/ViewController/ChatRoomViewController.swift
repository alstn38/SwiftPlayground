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
            scrollToBottom(animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        configureView()
        setupTableView()
        setupKeyboardEvent()
    }
    
    private func setupNavigation() {
        guard let chatRoom else { return }
        navigationItem.title = chatRoom.chatroomName
    }
    
    private func configureView() {
        guard let chatRoom else { return }
        chatArray = addDateSeparator(chatRoom.chatList)
    }
    
    private func addDateSeparator(_ chatList: [Chat]) -> [Chat] {
        guard !chatList.isEmpty else { return [] }
        
        var newChatArray: [Chat] = []
        newChatArray.append(Chat(user: .dateSeparator, date: chatList[0].date, message: ""))
        newChatArray.append(chatList[0])
        
        for i in 1..<chatList.count {
            if !DateFormatterManager.shared.isEqualToDateString(chatList[i - 1].date, chatList[i].date) {
                newChatArray.append(Chat(user: .dateSeparator, date: chatList[i].date, message: ""))
            }
            
            newChatArray.append(chatList[i])
        }
        
        return newChatArray
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
        
        let dateSeparatorTableViewCellNib = UINib(nibName: DateSeparatorTableViewCell.identifier, bundle: nil)
        chatTableView.register(dateSeparatorTableViewCellNib, forCellReuseIdentifier: DateSeparatorTableViewCell.identifier)
    }
    
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(noticeKeyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc private func noticeKeyboardWillShow(_ sender: Notification) {
        scrollToBottom(animated: true)
    }
    
    private func scrollToBottom(animated: Bool) {
        guard !chatArray.isEmpty else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            chatTableView.scrollToRow(
                at: IndexPath(row: self.chatArray.count - 1, section: 0),
                at: .bottom,
                animated: animated
            )
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatMessage = chatArray[indexPath.row]
        let identifier: String
        
        if chatMessage.isDateSeparator {
            identifier = DateSeparatorTableViewCell.identifier
        } else {
            identifier = chatMessage.isUser ? SenderTableViewCell.identifier : ReceiverTableViewCell.identifier
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        ) as? ChatCellConfigurable else { return UITableViewCell() }
        
        cell.configureChatCell(chatMessage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITextViewDelegate
extension ChatRoomViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textViewPlaceholderLabel.isHidden = false
        }
    }
}

// MARK: - ReusableViewProtocol
extension ChatRoomViewController: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
