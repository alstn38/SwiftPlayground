//
//  BenefitItem.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import Foundation

struct BenefitItem: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    let systemImageName: String
    let isNewItem: Bool
}

extension BenefitItem {
    static let mainItem: BenefitItem = BenefitItem(
        title: "[70,000원]가입 지원금",
        subTitle: "빗썸 가입하고 미수령 지원금 받기 - AD",
        systemImageName: "star",
        isNewItem: false
    )
    
    static let items: [BenefitItem] = [
        BenefitItem(title: "오늘의 행운복권", subTitle: "포인트받기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "라이브쇼핑", subTitle: "포인트받기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "행운퀴즈", subTitle: "추가 혜택 보기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "이번 주 미션", subTitle: "얼마 받을지 보기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "두근두근 1등 찍기", subTitle: "포인트받기", systemImageName: "star", isNewItem: true),
        BenefitItem(title: "일주일 방문 미션", subTitle: "포인트받기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "머니 알림", subTitle: "포인트받기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "등록한 현금영수증 도착", subTitle: "포인트받기", systemImageName: "star", isNewItem: false),
        BenefitItem(title: "진행중인 이벤트", subTitle: "모아보기", systemImageName: "star", isNewItem: false),
    ]
}
