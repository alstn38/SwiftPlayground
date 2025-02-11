//
//  InputOutputViewModel.swift
//  MSUniverse
//
//  Created by 강민수 on 2/11/25.
//

import Foundation

protocol InputOutputViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
