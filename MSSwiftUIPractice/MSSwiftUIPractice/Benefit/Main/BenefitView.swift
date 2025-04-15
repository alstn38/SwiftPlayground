//
//  BenefitView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/14/25.
//

import SwiftUI

struct BenefitView: View {
    
    var body: some View {
        List {
            Section {
                BenefitItemView(item: BenefitItem.mainItem)
                    .listRowBackground(Color.gray.opacity(0.2))
            }

            Section {
                ForEach(BenefitItem.items, id: \.id) { item in
                    BenefitItemView(item: item)
                        .listRowBackground(Color.gray.opacity(0.2))
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.black)
    }
}

#Preview {
    BenefitView()
}
