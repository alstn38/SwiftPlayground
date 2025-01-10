//
//  ChatRoomViewController.swift
//  MSTalk
//
//  Created by 강민수 on 1/10/25.
//

import UIKit

final class ChatRoomViewController: UIViewController {

    @IBOutlet private var chatTableView: UITableView!
    @IBOutlet private var textViewBackgroundView: UIView!
    @IBOutlet private var textViewPlaceholderLabel: UILabel!
    @IBOutlet private var chatTextView: UITextView!
    @IBOutlet private var chatSendButton: UIButton!
    var chatRoomName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
    }
    
    private func setupNavigation() {
        guard let chatRoomName else { return }
        navigationItem.title = chatRoomName
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
