//
//  TouristAttractionViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/7/25.
//

import Kingfisher
import UIKit

final class TouristAttractionViewController: UIViewController {
    
    static let identifier: String = "TouristAttractionViewController"
    var travelInfo: Travel?
    
    @IBOutlet private var locationImageView: UIImageView!
    @IBOutlet private var locationNameLabel: UILabel!
    @IBOutlet private var locationDescriptionLabel: UILabel!
    @IBOutlet private var anotherLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        configureView()
    }
    
    /// View의 Data를 전달하는 메서드
    func configureView() {
        guard let travelInfo else { return }
        if let cityImageLink = travelInfo.travel_image,
           let url = URL(string: cityImageLink) {
            locationImageView.kf.setImage(with: url)
        } else {
            locationImageView.image = UIImage(systemName: "photo.artframe")
        }
        
        locationNameLabel.text = travelInfo.title
        locationDescriptionLabel.text = travelInfo.description
    }
    
    /// 네비게이션을 설정하는 메서드
    private func setupNavigation() {
        navigationItem.title = "관광지 화면"
    }
    
    /// 뷰의 속성을 설정하는 메서드
    private func setupView() {
        locationImageView.layer.cornerRadius = 10
        locationImageView.contentMode = .scaleToFill
        locationImageView.tintColor = .black
        
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
