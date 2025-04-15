//
//  WalletItem.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/15/25.
//

import Foundation

struct WalletItem {
    let id = UUID()
    let title: String
    let subtitle: String
    let money: Int
    var isFavorite: Bool
}

extension WalletItem {
    
    static let items: [WalletItem] = [
        WalletItem(title: "카카오뱅크 입출금", subtitle: "입출금 통장", money: 1_230_000, isFavorite: true),
        WalletItem(title: "토스뱅크 저축", subtitle: "월급 통장", money: 3_500_000, isFavorite: true),
        WalletItem(title: "신한 체크카드", subtitle: "체크카드 결제 계좌", money: 452_000, isFavorite: false),
        WalletItem(title: "삼성 페이", subtitle: "모바일 결제 계좌", money: 78_900, isFavorite: false),
        WalletItem(title: "비상금 통장", subtitle: "긴급자금 보관", money: 5_000_000, isFavorite: false),
        WalletItem(title: "주식 계좌", subtitle: "한국투자증권", money: 8_210_000, isFavorite: true),
        WalletItem(title: "연금저축", subtitle: "IRP 연금 계좌", money: 12_000_000, isFavorite: true),
        WalletItem(title: "저금통", subtitle: "자동 저축 모음", money: 82_500, isFavorite: false),
        WalletItem(title: "부모님 용돈", subtitle: "정기 이체 계좌", money: 300_000, isFavorite: false),
        WalletItem(title: "해외결제 예비금", subtitle: "USD 환전용", money: 1_100_000, isFavorite: false)
    ]
}
