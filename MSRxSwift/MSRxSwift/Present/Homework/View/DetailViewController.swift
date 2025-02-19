//
//  DetailViewController.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/19/25.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let person: Person
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.title = person.name
    }
}
