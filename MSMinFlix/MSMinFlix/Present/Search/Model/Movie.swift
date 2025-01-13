//
//  Movie.swift
//  MSMinFlix
//
//  Created by 강민수 on 1/13/25.
//

import Foundation

struct Movie {
    let number: String
    let title: String
    let date: String
    
    static func dummy() -> [Movie] {
        return [
            Movie(number: "1", title: "기생충", date: "2020-02-07"),
            Movie(number: "2", title: "명량", date: "2020-07-30"),
            Movie(number: "3", title: "신과함께: 죄와 벌", date: "2020-08-01"),
            Movie(number: "4", title: "극한직업", date: "2020-01-23"),
            Movie(number: "5", title: "겨울왕국 2", date: "2020-11-21"),
            Movie(number: "6", title: "택시운전사", date: "2020-08-02"),
            Movie(number: "7", title: "신과함께: 인과 연", date: "2020-08-01"),
            Movie(number: "8", title: "왕의 남자", date: "2020-12-29"),
            Movie(number: "9", title: "부산행", date: "2020-07-20"),
            Movie(number: "10", title: "1987", date: "2020-12-27"),
            Movie(number: "11", title: "범죄도시", date: "2020-10-03"),
            Movie(number: "12", title: "해운대", date: "2020-07-22"),
            Movie(number: "13", title: "국제시장", date: "2020-12-17"),
            Movie(number: "14", title: "기억의 밤", date: "2020-11-29"),
            Movie(number: "15", title: "암살", date: "2020-07-22"),
            Movie(number: "16", title: "관상", date: "2020-09-11"),
            Movie(number: "17", title: "변호인", date: "2020-12-18"),
            Movie(number: "18", title: "화차", date: "2020-03-08"),
            Movie(number: "19", title: "도둑들", date: "2020-07-25"),
            Movie(number: "20", title: "마녀", date: "2020-06-27"),
            Movie(number: "21", title: "올드보이", date: "2020-03-20"),
            Movie(number: "22", title: "괴물", date: "2020-07-27"),
            Movie(number: "23", title: "친절한 금자씨", date: "2020-11-18"),
            Movie(number: "24", title: "추격자", date: "2020-02-14"),
            Movie(number: "25", title: "아가씨", date: "2020-06-01"),
            Movie(number: "26", title: "실미도", date: "2020-02-05"),
            Movie(number: "27", title: "태극기 휘날리며", date: "2020-01-22"),
            Movie(number: "28", title: "웰컴 투 동막골", date: "2020-08-15"),
            Movie(number: "29", title: "청년경찰", date: "2020-08-09"),
            Movie(number: "30", title: "오늘 밤, 세계에서 이 사랑이 사라진다 해도 넌 여기에 없을거야", date: "2020-01-23")
        ]
    }
}
