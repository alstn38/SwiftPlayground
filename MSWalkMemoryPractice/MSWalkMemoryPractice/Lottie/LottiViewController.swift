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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        animationView = LottieAnimationView(name: "walkLottie")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit

        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }

        animationView.play()
    }
}
