//
//  WeatherViewController.swift
//  MSMap
//
//  Created by 강민수 on 2/3/25.
//

import MapKit
import SnapKit
import UIKit

final class WeatherViewController: UIViewController {
    
    private let defaultLocation = CLLocationCoordinate2D(
        latitude: 37.65453812853827,
        longitude: 127.04992470255024
    )
    
    private let locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()
     
    private let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.text = "날씨 정보를 불러오는 중..."
        label.textColor = .black
        return label
    }()
    
    private let currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupDelegate()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        [mapView, weatherInfoLabel, currentLocationButton, refreshButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        weatherInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        locationManager.delegate = self
    }
    
    private func updateCurrentLocation(_ location: CLLocationCoordinate2D?) {
        let location = location ?? defaultLocation
        if let annotations = mapView.annotations as? MKAnnotation {
            mapView.removeAnnotation(annotations)
        }
        moveToRegion(location: location)
        createAnnotation(location: location)
        getWeatherInfo(location: location)
        locationManager.stopUpdatingLocation()
    }
    
    private func moveToRegion(location: CLLocationCoordinate2D) {
        let center = location
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    private func createAnnotation(location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    private func getWeatherInfo(location: CLLocationCoordinate2D) {
        let request = WeatherRequest.currentWeather(
            latitude: location.latitude,
            longitude: location.longitude
        )
        
        NetworkManager.shared.request(urlRequest: request, responseType: Weather.self) { [weak self] response in
            switch response {
            case .success(let success):
                self?.weatherInfoLabel.text = success.description
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    /// 사용자의 현재 정보를 가져오는 메서드
    private func refreshCurrentLocation() {
        checkDeviceLocationAuth { result in
            DispatchQueue.main.async {
                switch result {
                case true:
                    self.checkCurrentLocationStatus()
                case false:
                    self.presentToSettingAppWithLocation()
                }
            }
        }
    }
    
    /// 사용자 기기의 위치 권한(시스템 설정)을 확인하는 메서드
    private func checkDeviceLocationAuth(completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    /// 사용자의 앱 위치 권한을 확인하고 관련 동작을 수행하는 메서드
    private func checkCurrentLocationStatus() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            updateCurrentLocation(nil)
            presentToSettingAppWithLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            presentWarningAlert()
        }
    }
    
    // MARK: - Actions
    @objc private func currentLocationButtonTapped() {
        refreshCurrentLocation()
    }
    
    @objc private func refreshButtonTapped() {
        refreshCurrentLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    /// 사용자의 위치를 성공적으로 가져왔을 때 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateCurrentLocation(locations.last?.coordinate)
    }
    
    /// 사용자의 위치를 가져오는 것에 실패했을 때 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        presentWarningAlert()
    }
    
    /// iOS 14+
    /// 사용자의 위치 권한 상태가 변경되었을 때 호출되는 메서드
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        refreshCurrentLocation()
    }
    
    /// iOS 14미만
    /// 사용자의 위치 권한 상태가 변경되었을 때 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        refreshCurrentLocation()
    }
}
