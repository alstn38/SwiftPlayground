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
    private var restaurantArray: [Restaurant] = RestaurantList().restaurantArray
    private let foodCategoryTypeArray: [FoodCategoryType] = FoodCategoryType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupMapView()
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
    
    private func setupMapView() {
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.65430, longitude: 127.04777)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 150, longitudinalMeters: 150)
        
        restaurantArray.forEach { mapView.addAnnotation(makeAnnotation($0)) }
    }
    
    /// Map의 Annotation을 반환하는 메서드
    private func makeAnnotation(_ restaurant: Restaurant) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = restaurant.name
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: restaurant.latitude,
            longitude: restaurant.longitude
        )
        
        return annotation
    }
    
    private func presentActionSheet() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        foodCategoryTypeArray.forEach { category in
            let action = UIAlertAction(
                title: category.rawValue,
                style: .default,
                handler: { [weak self] _ in
                    self?.filterRestaurant(category)
                }
            )
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    /// 필터 선택시 동작하는 메서드
    private func filterRestaurant(_ category: FoodCategoryType) {
        print(#function, category.rawValue)
    }
    
    /// 필터 선택 버튼을 눌렀을 때 동작하는 메서드
    @objc private func filterButtonDidTap(_ sender: UIBarButtonItem) {
        presentActionSheet()
    }
}

extension RestaurantViewController: MKMapViewDelegate { }
