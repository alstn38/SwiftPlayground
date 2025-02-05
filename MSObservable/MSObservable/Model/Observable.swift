//
//  Observable.swift
//  MSObservable
//
//  Created by 강민수 on 2/5/25.
//

import Foundation

final class Observable<T> {
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    var closure: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping ((T) -> Void)) {
        self.closure = closure
        closure(value)
    }
    
    func lazyBind(closure: @escaping ((T) -> Void)) {
        self.closure = closure
    }
}
