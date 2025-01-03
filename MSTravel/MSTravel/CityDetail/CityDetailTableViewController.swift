//
//  CityDetailTableViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import UIKit

final class CityDetailTableViewController: UITableViewController {
    
    private var travelArray: [Travel] = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    /// navigation을 설정하는 메서드
    private func setupNavigation() {
        title = "도시 상세 정보"
    }
}

extension CityDetailTableViewController {
    
    /// TableView의 Section별 Row의 개수를 반환하는 메서드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelArray.count
    }
    
    /// TableView의 Section별 Row를 반환하는 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CityDetailTableViewCell",
            for: indexPath
        ) as? CityDetailTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
