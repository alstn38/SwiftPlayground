//
//  Observable.swift
//  MSShopping
//
//  Created by 강민수 on 2/6/25.
//

import Foundation

final class CustomObservable<T> {
    
    private var value: T {
        didSet {
            closure?(value)
        }
    }
    
    private var closure: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func send(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}
