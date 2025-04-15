//
//  CustomText.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import SwiftUI

private struct CustomText: ViewModifier {
    let font: Font
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(color)
    }
}

extension View {
    
    func customTextStyle(font: Font, color: Color) -> some View {
        modifier(CustomText(font: font, color: color))
    }
}
