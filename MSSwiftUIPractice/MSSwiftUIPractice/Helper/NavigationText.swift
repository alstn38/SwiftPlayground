//
//  NavigationText.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import SwiftUI

private struct NavigationText: ViewModifier {
    
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
    }
}

extension View {
    
    func asLargeNavigationTitle(_ title: String) -> some View {
        modifier(NavigationText(title: title))
    }
}
