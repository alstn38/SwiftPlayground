//
//  VerticalDividerView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct VerticalDividerView: View {
    var body: some View {
        Divider()
            .frame(width: 1, height: 40)
            .background(Color.gray.opacity(0.5))
            .padding(.horizontal, 6)
    }
}

#Preview {
    VerticalDividerView()
}
