//
//  ProductItem.swift
//  MSSwiftUIPractice
//
//  Created by 강민수 on 4/16/25.
//

import Foundation

struct ProductItem: Hashable {
    let id = UUID()
    let image: String
    let mallName: String
    let title: String
    let lowPrice: String
    var favorite: Bool
}

extension ProductItem {
    
    static let items: [ProductItem] = [
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8275464/82754642762.18.jpg",
            mallName: "과일꾼",
            title: "사과 가정용 선물세트 못난이 부사 꿀사과",
            lowPrice: "25900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_1261282/12612822402.4.jpg",
            mallName: "청송사과 옛골농원",
            title: "청송 사과 햇 부사 꿀사과 못난이 선물용 5kg",
            lowPrice: "45900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8336119/83361198940.2.jpg",
            mallName: "주왕산털보네하늘사과",
            title: "털보네 껍질째먹는 꿀사과 흠집사과 못난이 흠과 4kg",
            lowPrice: "27800원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8235835/82358356731.109.jpg",
            mallName: "정담아농원",
            title: "사과 청송사과 문경 꿀 부사 못난이 흠과 5kg 10kg",
            lowPrice: "35900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8256261/82562614372.16.jpg",
            mallName: "아침이슬사과",
            title: "사과 경북 못난이 꿀사과 흠집 주스용 쥬스용 5kg 10kg",
            lowPrice: "17900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8284497/82844973796.10.jpg",
            mallName: "달콤한농부들",
            title: "사과 청송 안동 부사 못난이 꿀사과",
            lowPrice: "19900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8275560/82755608411.3.jpg",
            mallName: "솔스윗",
            title: "사과 청송 부사 시나노골드 못난이 꿀사과 5kg 10kg",
            lowPrice: "32900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8273956/82739564476.4.jpg",
            mallName: "다농이네",
            title: "사과 경북 껍질째먹는 부사 세척사과 2kg 3kg",
            lowPrice: "17900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8231796/82317960446.3.jpg",
            mallName: "청송재벌농원",
            title: "[최상품] 청송사과 얼음골사과 명품 꿀 부사 미시마 사과 유명한곳 선물세트 선물용 못난이",
            lowPrice: "50500원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8871901/88719011053.10.jpg",
            mallName: "피에스 팜",
            title: "못난이 사과 가정용 부사 주스용 사과 10kg 보조개 흠집 쥬스용 사과 5kg",
            lowPrice: "19900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8685832/86858326769.jpg",
            mallName: "늘품농업회사법인주식회사",
            title: "시나노골드 사과 늘품 가정용 신선한 못난이 흠집 새콤달콤 꿀사과 3kg",
            lowPrice: "17900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8769555/87695558230.jpg",
            mallName: "얼음골사과부성농원",
            title: "[산지직송]밀양얼음골사과 부성농원 5kg 10kg 가정용 선물용 꿀부사 못난이(흠과)",
            lowPrice: "30000원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_1242591/12425918853.3.jpg",
            mallName: "잇츠푸드",
            title: "당도선별 GAP 저탄소 세척사과 가정용 부사 2kg,3kg",
            lowPrice: "14900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8277216/82772167375.jpg",
            mallName: "고 씨네농장",
            title: "사과 청송 안동 부사 꿀사과 못난이 5kg 10kg",
            lowPrice: "35900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8370002/83700029746.1.jpg",
            mallName: "빨간과일",
            title: "사과 청송 문경 껍질째먹는 세척",
            lowPrice: "33800원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8414192/84141921134.jpg",
            mallName: "솔스윗",
            title: "청송 꿀 세척사과 껍질째먹는 경북 사과 5kg 10kg",
            lowPrice: "53900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8860758/88607580247.3.jpg",
            mallName: "싱싱과",
            title: "사과 부사 경북 청송 고당도 꿀사과 5kg 10kg",
            lowPrice: "37900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8010228/80102288884.15.jpg",
            mallName: "황금찬농수산",
            title: "[황금찬] 거창 당도좋은 햇 부사 사과 가정용 흠과 2.5kg 5kg",
            lowPrice: "39800원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8343982/83439829432.4.jpg",
            mallName: "문경사과 대박농원",
            title: "대박농원 사과 꿀 부사 문경 청송 선물용 흠집 못난이 사과",
            lowPrice: "39900원",
            favorite: false
        ),
        ProductItem(
            image: "https://shopping-phinf.pstatic.net/main_8460564/84605641451.19.jpg",
            mallName: "세모농.",
            title: "꿀 부사 사과 문경 경북 안동 청송 사과 못난이 가정용 10kg 5kg 2.5kg",
            lowPrice: "25900원",
            favorite: false
        )
    ]
}
