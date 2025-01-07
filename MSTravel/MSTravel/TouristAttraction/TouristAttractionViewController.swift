//
//  TouristAttractionViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import UIKit

final class TouristAttractionViewController: UIViewController {
    
    static let identifier: String = "TouristAttractionViewController"
    
    @IBOutlet var locationImageView: UIImageView!
    @IBOutlet var locationNameLabel: UILabel!
    @IBOutlet var locationDescriptionLabel: UILabel!
    @IBOutlet var anotherLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
    }
    
    /// 네비게이션을 설정하는 메서드
    private func setupNavigation() {
        navigationItem.title = "관광지 화면"
    }
    
    /// 뷰의 속성을 설정하는 메서드
    private func setupView() {
        locationImageView.layer.cornerRadius = 10
        locationImageView.contentMode = .scaleToFill
        
        locationNameLabel.font = .boldSystemFont(ofSize: 36)
        locationNameLabel.textColor = .black
        locationNameLabel.numberOfLines = 1
        locationNameLabel.textAlignment = .center
        
        locationDescriptionLabel.font = .boldSystemFont(ofSize: 28)
        locationDescriptionLabel.textColor = .black
        locationDescriptionLabel.numberOfLines = 0
        locationDescriptionLabel.textAlignment = .center
        
        anotherLocationButton.layer.cornerRadius = 20
        anotherLocationButton.backgroundColor = UIColor(red: 85/255, green: 203/255, blue: 205/255, alpha: 1.0)
        anotherLocationButton.setTitle("다른 관광지 보러 가기", for: .normal)
        anotherLocationButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        anotherLocationButton.setTitleColor(.white, for: .normal)
    }
}
