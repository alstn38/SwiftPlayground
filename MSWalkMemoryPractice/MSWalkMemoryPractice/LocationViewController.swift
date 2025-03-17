//
//  ViewController.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 3/17/25.
//

import UIKit
import SnapKit
import MapKit

final class LocationViewController: UIViewController {
    
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureView() {
        
    }
    
    private func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    private func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
