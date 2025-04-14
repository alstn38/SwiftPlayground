//
//  EventView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct EventView: View {
    let title: String
    
    var body: some View {
        ZStack {
            Image("event_background")
                .resizable()
                .scaledToFill()
                .background(Color.purple)

            Text(title)
                .foregroundStyle(.white)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
        .frame(height: 100)
        .clipShape(.buttonBorder)
    }
}
