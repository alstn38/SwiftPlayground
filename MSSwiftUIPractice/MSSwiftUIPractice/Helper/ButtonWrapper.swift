//
//  ButtonWrapper.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
    }
}

extension View {
    
    func wrapToButton(action: @escaping () -> Void) -> some View {
        return modifier(ButtonWrapper(action: action))
    }
}
