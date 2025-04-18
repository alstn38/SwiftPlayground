//
//  BenefitItemView.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import SwiftUI

struct BenefitItemView: View {
    let item: BenefitItem
    
    var body: some View {
        HStack {
            Image(systemName: item.systemImageName)
                .frame(width: 50, height: 50)
                .background(.gray)
                .clipShape(.circle)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .customTextStyle(font: .title3, color: .white)
                    .bold()
                
                Text(item.subTitle)
                    .customTextStyle(font: .callout, color: .blue)
            }
            Spacer()
            
            if item.isNewItem {
                Text("새로 나온")
                    .customTextStyle(font: .caption, color: .white)
                    .bold()
                    .padding(EdgeInsets(
                        top: 4,
                        leading: 8,
                        bottom: 4,
                        trailing: 8)
                    )
                    .background(.gray)
                    .clipShape(.capsule)
            }
        }
        .background(.clear)
    }
}

#Preview {
    BenefitItemView(
        item: BenefitItem(
            title: "오늘의 행운복권",
            subTitle: "포인트받기",
            systemImageName: "star",
            isNewItem: true
        )
    )
}
