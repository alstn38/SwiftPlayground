//
//  CountryView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct CountryView: View {
    let systemImageName: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImageName)
                .font(.system(size: 18, weight: .semibold))
            
            Text(label)
                .font(.footnote)
                .foregroundStyle(.white)
        }
        .frame(width: 80, height: 80)
        .background(.gray)
        .clipShape(.buttonBorder)
    }
}
