//
//  ViewController.swift
//  MSWalkMemoryPractice
//
//  Created by 강민수 on 3/17/25.
//

import UIKit
import SnapKit
import MapKit

//final class LocationViewController: UIViewController {
//    
//    private let mapView = MKMapView()
//    private let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureView()
//        configureHierarchy()
//        configureLayout()
//    }
//    
//    private func configureView() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    private func configureHierarchy() {
//        view.addSubview(mapView)
//    }
//    
//    private func configureLayout() {
//        mapView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//    
//    /// 사용자의 현재 정보를 가져오는 메서드
//    private func refreshCurrentLocation() {
//        checkDeviceLocationAuth { result in
//            DispatchQueue.main.async {
//                switch result {
//                case true:
//                    self.checkCurrentLocationStatus()
//                case false:
//                    self.presentToSettingAppWithLocation()
//                }
//            }
//        }
//    }
//    
//    /// 사용자 기기의 위치 권한(시스템 설정)을 확인하는 메서드
//    private func checkDeviceLocationAuth(completionHandler: @escaping (Bool) -> Void) {
//        DispatchQueue.global().async {
//            if CLLocationManager.locationServicesEnabled() {
//                completionHandler(true)
//            } else {
//                completionHandler(false)
//            }
//        }
//    }
//    
//    /// 사용자의 앱 위치 권한을 확인하고 관련 동작을 수행하는 메서드
//    private func checkCurrentLocationStatus() {
//        let status = locationManager.authorizationStatus
//        
//        switch status {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .denied:
//            updateCurrentLocation(nil)
//            presentToSettingAppWithLocation()
//        case .authorizedWhenInUse:
//            locationManager.startUpdatingLocation()
//        default:
//            presentWarningAlert()
//        }
//    }
//}
//
//// MARK: - CLLocationManagerDelegate
//extension LocationViewController: CLLocationManagerDelegate {
//    
//    /// 사용자의 위치를 성공적으로 가져왔을 때 호출되는 메서드
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        updateCurrentLocation(locations.last?.coordinate)
//    }
//    
//    /// 사용자의 위치를 가져오는 것에 실패했을 때 호출되는 메서드
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
//        presentWarningAlert()
//    }
//    
//    /// iOS 14+
//    /// 사용자의 위치 권한 상태가 변경되었을 때 호출되는 메서드
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        refreshCurrentLocation()
//    }
//    
//    /// iOS 14미만
//    /// 사용자의 위치 권한 상태가 변경되었을 때 호출되는 메서드
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        refreshCurrentLocation()
//    }
//}
