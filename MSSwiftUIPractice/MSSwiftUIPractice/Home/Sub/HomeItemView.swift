//
//  HomeItemView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct HomeItemView: View {
    let homeMenuItem: HomeMenuItem
    
    var body: some View {
        HStack {
            Image(systemName: homeMenuItem.systemImage)
                .foregroundColor(.white)
            
            Text(homeMenuItem.title)
                .customTextStyle(font: .headline, color: .white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}
