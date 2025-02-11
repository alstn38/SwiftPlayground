//
//  NasaViewModel.swift
//  MSUniverse
//
//  Created by 강민수 on 2/11/25.
//

import Foundation

final class NasaViewModel: NSObject, InputOutputViewModel {
    
    struct Input {
        let requestButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let requestButtonState: Observable<Bool>
        let progressViewHidden: Observable<Bool>
        let universeImage: Observable<Data?>
        let progressLabelText: Observable<String?>
        let progressValue: Observable<Float>
    }
    
    private var total: Double = 0.0
    private var buffer: Data = Data()
    
    private let requestButtonStateSubject: Observable<Bool> = Observable(true)
    private let progressViewHiddenSubject: Observable<Bool> = Observable(true)
    private let universeImageSubject: Observable<Data?> = Observable(Data())
    private let progressLabelTextSubject: Observable<String?> = Observable(nil)
    private let progressValueSubject: Observable<Float> = Observable(0)
    
    func transform(from input: Input) -> Output {
        input.requestButtonDidTap.bind { [weak self] _ in
            guard let self else { return }
            buffer = Data()
            progressValueSubject.send(0)
            progressViewHiddenSubject.send(false)
            requestButtonStateSubject.send(false)
            fetchUniversePicture()
        }
        
        return Output(
            requestButtonState: requestButtonStateSubject,
            progressViewHidden: progressViewHiddenSubject,
            universeImage: universeImageSubject,
            progressLabelText: progressLabelTextSubject,
            progressValue: progressValueSubject
        )
    }
    
    private func fetchUniversePicture() {
        let request = URLRequest(url: UniversePicture.photo, timeoutInterval: 7)
        let configuration = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main
        )
        configuration.dataTask(with: request).resume()
    }
}

// MARK: - URLSessionDataDelegate
extension NasaViewModel: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        guard let response = response as? HTTPURLResponse,
              let contentLength = response.value(forHTTPHeaderField: "Content-Length"),
              let contentLength = Double(contentLength)
        else {
            return .cancel
        }
        
        total = contentLength
        return .allow
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer.append(data)
        
        let result = Double(buffer.count) / total
        progressLabelTextSubject.send(String(format: "%.2f", result * 100) + " / 100")
        progressValueSubject.send(Float(result))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error {
            progressLabelTextSubject.send("사진을 가져오는데 문제가 발생했습니다. - \(error)")
            universeImageSubject.send(nil)
            return
        }
        
        guard !buffer.isEmpty else {
            progressLabelTextSubject.send("사진을 가져오는데 문제가 발생했습니다.")
            return
        }
        
        universeImageSubject.send(buffer)
        progressLabelTextSubject.send(nil)
        progressViewHiddenSubject.send(true)
        requestButtonStateSubject.send(true)
    }
}
