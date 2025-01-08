//
//  ViewController.swift
//  MSRestaurant
//
//  Created by 강민수 on 1/8/25.
//

import MapKit
import UIKit

final class RestaurantViewController: UIViewController {

    @IBOutlet private var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    private func setupNavigation() {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(filterButtonDidTap)
        )
        barButtonItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    /// 필터 선택 버튼을 눌렀을 때 동작하는 메서드
    @objc private func filterButtonDidTap(_ sender: UIBarButtonItem) {
        
    }
}
