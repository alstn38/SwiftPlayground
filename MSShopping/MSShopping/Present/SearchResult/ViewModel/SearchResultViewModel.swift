//
//  SearchResultViewModel.swift
//  MSShopping
//
//  Created by 강민수 on 2/6/25.
//

import Alamofire
import Foundation

final class SearchResultViewModel {
    
    struct Input {
        let viewDidLoad: CustomObservable<Void>
        let selectedFilterButtonDidTap: CustomObservable<FilterButton.FilterButtonType>
        let didRequestMoreResult: CustomObservable<Void>
    }
    
    struct Output {
        let indicatorAnimate: CustomObservable<Bool>
        let productTotalCountText: CustomObservable<String?>
        let searchProductArrayUpdate: CustomObservable<Void>
        let alertError: CustomObservable<String>
    }
    
    private let indicatorAnimateSubject: CustomObservable<Bool> = CustomObservable(false)
    private let productTotalCountTextSubject: CustomObservable<String?> = CustomObservable(nil)
    private let searchProductArrayUpdateSubject: CustomObservable<Void> = CustomObservable(())
    private let alertErrorSubject: CustomObservable<String> = CustomObservable("")
    
    private(set) var searchProductArray: [Item] = []
    private var searchedText: String
    private var selectedFilterButtonType: FilterButton.FilterButtonType = .accuracy
    private var currentPage: Int = 1
    private var maximumPage: Int = 1
    
    init(searchedText: String) {
        self.searchedText = searchedText
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            updateProductResult()
        }
        
        input.selectedFilterButtonDidTap.bind { [weak self] filterButtonType in
            guard let self else { return }
            guard selectedFilterButtonType != filterButtonType else { return }
            selectedFilterButtonType = filterButtonType
            currentPage = 1
            maximumPage = 1
            updateProductResult()
        }
        
        input.didRequestMoreResult.bind { [weak self] _ in
            guard let self else { return }
            currentPage += 1
            
            guard currentPage <= maximumPage else { return }
            updateProductResult()
        }
        
        return Output(
            indicatorAnimate: indicatorAnimateSubject,
            productTotalCountText: productTotalCountTextSubject,
            searchProductArrayUpdate: searchProductArrayUpdateSubject,
            alertError: alertErrorSubject
        )
    }
    
    private func updateProductResult() {
        indicatorAnimateSubject.send(true)
        NetworkManager.shared.getShoppingResult(
            searchedText: searchedText,
            sortType: selectedFilterButtonType.query,
            page: currentPage
        ) { [weak self] result in
            guard let self else { return }
            indicatorAnimateSubject.send(false)
            
            switch result {
            case .success(let value):
                maximumPage = value.total
                productTotalCountTextSubject.send("\(value.total.formatted())개의 검색 결과")
                updateSearchProductArray(value.items)
                
            case .failure:
                alertErrorSubject.send("결과 값을 불러올 수 없습니다.")
            }
        }
    }
    
    private func updateSearchProductArray(_ items: [Item]) {
        if currentPage == 1 {
            searchProductArray = items
        } else {
            searchProductArray.append(contentsOf: items)
        }
        searchProductArrayUpdateSubject.send(())
    }
}
