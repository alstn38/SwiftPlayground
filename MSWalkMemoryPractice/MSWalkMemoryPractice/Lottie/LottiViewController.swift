//
//  LottiViewController.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 3/24/25.
//

import UIKit
import Lottie
import SnapKit

final class LottiViewController: UIViewController {
    
    private var animationView: LottieAnimationView!
    private let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .angryEmoji)
//        imageView.image = UIImage(resource: .) ?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red // 첫 번째 이미지 색상
        return imageView
    }()
    
    private let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .loveEmoji)
        imageView.tintColor = .blue // 두 번째 이미지 색상
        return imageView
    }()
    
    private let imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .tiredEmoji)
        imageView.tintColor = .green // 세 번째 이미지 색상
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        animationView = LottieAnimationView(name: "walkdd")
//        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit

        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
//
////        animationView.play()
//        animationView.play(fromFrame: 60, toFrame: 157, loopMode: .loop)
        
        view.addSubview(imageView1)
        view.addSubview(imageView2)
        view.addSubview(imageView3)
        
        // SnapKit으로 레이아웃 설정
//        setupLayout()
    }
    
    private func setupLayout() {
        // 이미지 1 (50x50, 상단 중앙)
        imageView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(50)
        }
        
        // 이미지 2 (80x80, 이미지 1 아래)
        imageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView1.snp.bottom).offset(20)
            make.width.height.equalTo(300)
        }
        
        // 이미지 3 (100x100, 이미지 2 아래)
        imageView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView2.snp.bottom).offset(20)
            make.width.height.equalTo(400)
        }
    }
}
