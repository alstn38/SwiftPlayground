//
//  UserListViewModel.swift
//  MSObservable
//
//  Created by 강민수 on 2/5/25.
//

import Foundation

final class UserListViewModel {
    
    enum InputButtonType {
        case loadButton
        case resetButton
        case addButton
    }
    
    let inputButtonDidTap: Observable<InputButtonType> = Observable(.resetButton)
    let outputPersonArray: Observable<[Person]> = Observable([])
    
    init() {
        inputButtonDidTap.lazyBind { [weak self] buttonType in
            guard let self else { return }
            switch buttonType {
            case .loadButton:
                let newLoadData = loadPersonArrayData()
                outputPersonArray.value.append(contentsOf: newLoadData)
                
            case .resetButton:
                outputPersonArray.value = []
                
            case .addButton:
                let newLoadData = loadPersonData()
                outputPersonArray.value.append(newLoadData)
            }
        }
    }
    
    private func loadPersonArrayData() -> [Person] {
        let newLoadData = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
        
        return newLoadData
    }
    
    private func loadPersonData() -> Person {
        let names = [
            "James", "Mary", "John", "Patricia", "Robert",
            "Jennifer", "Michael", "Linda", "William", "Elizabeth",
            "David", "Barbara", "Richard", "Susan", "Joseph",
            "Jessica", "Thomas", "Sarah", "Charles", "Karen"
        ]
        
        let user = Person(
            name: names.randomElement()!,
            age: Int.random(in: 20...70)
        )
        
        return user
    }
}
