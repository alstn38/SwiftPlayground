//
//  HomeworkViewModel.swift
//  MSRxSwift
//
//  Created by 강민수 on 2/19/25.
//

import Foundation
import RxSwift
import RxRelay

final class HomeworkViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let searchTextDidChange: Observable<String>
        let personItemDidTap: Observable<Person>
        let detailButtonDidTap: Observable<Int>
    }
    
    struct Output {
        let updatePersonData: Observable<[Person]>
        let updateRecentSearchData: Observable<[String]>
        let moveToDetailView: Observable<Person>
    }
    
    private let disposeBag = DisposeBag()
    private let personData = Person.dummy()
    private let updatePersonDataRelay: PublishRelay<[Person]> = PublishRelay()
    private let updateRecentSearchDataRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    private let moveToDetailViewRelay: PublishRelay<Person> = PublishRelay()
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                owner.updatePersonDataRelay.accept(owner.personData)
            }
            .disposed(by: disposeBag)
        
        input.searchTextDidChange
            .map { $0.lowercased() }
            .withUnretained(self)
            .map { owner, text in
                let filteredData = text.isEmpty
                ? owner.personData
                : owner.personData.filter { $0.name.lowercased().contains(text) }
                return filteredData
            }
            .bind(to: updatePersonDataRelay)
            .disposed(by: disposeBag)
        
        input.personItemDidTap
            .map { $0.name }
            .withLatestFrom(updateRecentSearchDataRelay) { name, searchArray in
                var newSearchArray = searchArray
                if let index = searchArray.firstIndex(of: name) {
                    newSearchArray.remove(at: index)
                }
                newSearchArray.insert(name, at: 0)
                return newSearchArray
            }
            .bind(to: updateRecentSearchDataRelay)
            .disposed(by: disposeBag)
            
        input.detailButtonDidTap
            .withLatestFrom(updatePersonDataRelay) { index, personArray in
                return personArray[index]
            }
            .bind(to: moveToDetailViewRelay)
            .disposed(by: disposeBag)
        
        return Output(
            updatePersonData: updatePersonDataRelay.asObservable(),
            updateRecentSearchData: updateRecentSearchDataRelay.asObservable(),
            moveToDetailView: moveToDetailViewRelay.asObservable()
        )
    }
}
