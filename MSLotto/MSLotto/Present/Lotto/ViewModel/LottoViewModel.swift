//
//  LottoViewModel.swift
//  MSLotto
//
//  Created by 강민수 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel: InputOutputModel{
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let lottoPickerDidChange: Observable<Int>
        let observableNetworkButtonDidTap: Observable<Void>
        let singleNetworkButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let recentRoundNumber: Driver<String>
        let lottoNumberArray: Driver<[Int]>
        let lottoResult: Driver<Lotto>
        let presentAlert: Driver<(title: String, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(from input: Input) -> Output {
        let recentRoundNumberRelay = BehaviorRelay(value: String(getLottoAllRound()[0]))
        let lottoNumberArrayRelay = BehaviorRelay(value: getLottoAllRound())
        let lottoResultRelay = PublishRelay<Lotto>()
        let presentAlertRelay = PublishRelay<(title: String, message: String)>()
        
        /// viewDidLoad와 lottoPickerDidChange의 방출에서 같은 통신코드가 반복되고 있다.
        /// 따라서, combineLatest를 활용하여 이 두 개를 함께 사용할 수 있을 것 같다. 하지만, Observable과 Single을 의도적으로 사용하기 위해 분리했다.
        /// Single을 통한 네트워크 통신
        input.viewDidLoad
            .withLatestFrom(lottoNumberArrayRelay)
            .filter { $0.count > 0 }
            .map { $0[0] }
            .map { LottoNetworkManager.shared.getLottoResultSingle(roundNumber: $0) }
            .bind(with: self) { owner, observer in
                observer.subscribe { lotto in
                    lottoResultRelay.accept(lotto)
                } onFailure: { error in
                    presentAlertRelay.accept((
                        title: "통신 오류",
                        message: error.localizedDescription
                    ))
                }
                .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        /// Observable을 통한 네트워크 통신
        input.lottoPickerDidChange
            .withLatestFrom(lottoNumberArrayRelay) { $1[$0] }
            .map { LottoNetworkManager.shared.getLottoResultObserver(roundNumber: $0) }
            .bind(with: self) { owner, observer in
                observer.subscribe { lotto in
                    lottoResultRelay.accept(lotto)
                } onError: { error in
                    presentAlertRelay.accept((
                        title: "통신 오류",
                        message: error.localizedDescription
                    ))
                }
                .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.lottoPickerDidChange
            .withLatestFrom(lottoNumberArrayRelay) { String($1[$0]) }
            .bind(to: recentRoundNumberRelay)
            .disposed(by: disposeBag)
        
        /// Observable을 위한 통신.
        input.observableNetworkButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.lottoPickerDidChange)
            .withLatestFrom(lottoNumberArrayRelay) { $1[$0] }
            .map { LottoNetworkManager.shared.getLottoResultObserver(roundNumber: $0) }
            .bind(with: self) { owner, observer in
                observer.subscribe { lotto in
                    lottoResultRelay.accept(lotto)
                } onError: { error in
                    presentAlertRelay.accept((
                        title: "통신 오류",
                        message: error.localizedDescription
                    ))
                }
                .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.singleNetworkButtonDidTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.lottoPickerDidChange)
            .withLatestFrom(lottoNumberArrayRelay) { $1[$0] }
            .map { LottoNetworkManager.shared.getLottoResultSingle(roundNumber: $0) }
            .bind(with: self) { owner, observer in
                observer.subscribe { lotto in
                    lottoResultRelay.accept(lotto)
                } onFailure: { error in
                    presentAlertRelay.accept((
                        title: "통신 오류",
                        message: error.localizedDescription
                    ))
                }
                .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        return Output(
            recentRoundNumber: recentRoundNumberRelay.asDriver(),
            lottoNumberArray: lottoNumberArrayRelay.asDriver(),
            lottoResult: lottoResultRelay.asDriver(onErrorJustReturn: Lotto.dummyLotto()),
            presentAlert: presentAlertRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
    
    /// 오늘 날짜 기준으로 최근 모든 로또 회차 가져오는 메서드
    private func getLottoAllRound() -> [Int] {
        let systemCalendar = Calendar.autoupdatingCurrent
        let startDateComponents = DateComponents(year: 2002, month: 12, day: 07)
        guard let startDay = systemCalendar.date(from: startDateComponents) else { return [0] }
        let today = Calendar.current.startOfDay(for: Date())
        let differenceDay = systemCalendar.dateComponents([.day], from: startDay, to: today).day ?? 0
        let recentRound = Int(differenceDay / 7) + 1
        return Array(1...recentRound).reversed()
    }
}
