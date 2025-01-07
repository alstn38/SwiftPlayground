//
//  CityDetailTableViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import UIKit

final class CityDetailTableViewController: UITableViewController {
    
    private var travelArray: [Travel] = TravelInfo().travel {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    /// navigation을 설정하는 메서드
    private func setupNavigation() {
        title = "도시 상세 정보"
    }
    
    /// 도시 좋아요 버튼을 클릭했을 때 동작하는 메서드
    @objc private func cityLikeButtonDidTap(_ sender: UIButton) {
        travelArray[sender.tag].like?.toggle()
    }
    
    /// 광고 여부에 따라 반환하는 TableView Cell 다르게 처리하는 메서드
    // 제네릭 도전해보기
    private func tableViewDequeReusableCell<T: UITableViewCell>(
        _ tableView: UITableView,
        cellType: T.Type,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: cellType),
            for: indexPath
        ) as? T else { return UITableViewCell() }
        
        if let advertisementCell = cell as? AdvertisementTableViewCell {
            advertisementCell.configureCell(travelArray[indexPath.row])
        } else if let cityDetailCell = cell as? CityDetailTableViewCell {
            cityDetailCell.configureCell(travelArray[indexPath.row], tag: indexPath.row)
            cityDetailCell.cityLikeButton.addTarget(self, action: #selector(cityLikeButtonDidTap), for: .touchUpInside)
        }
        
        return cell
    }
    
    /// 관광지 세부 화면으로 push하는 메서드
    private func pushToTouristAttractionViewController(with travel: Travel) {
        // 1. 스토리보드를 특정하기, name: - 스토리보드 파일 이름
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 전환할 뷰 컨트롤러를 가져오기.
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: TouristAttractionViewController.identifier
        ) as? TouristAttractionViewController else { return }
        viewController.travelInfo = travel
        
        // 3. 화면을 전환할 방법 선택하기 - 아래에서 위로 / modal / present
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CityDetailTableViewController {
    
    /// TableView의 Section별 Row의 개수를 반환하는 메서드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        travelArray.count
    }
    
    /// TableView의 Section별 Row를 반환하는 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isAdvertisement = travelArray[indexPath.row].ad
        
        let cell = isAdvertisement
        ? tableViewDequeReusableCell(tableView, cellType: AdvertisementTableViewCell.self, cellForRowAt: indexPath)
        : tableViewDequeReusableCell(tableView, cellType: CityDetailTableViewCell.self, cellForRowAt: indexPath)

        return cell
    }
    
    /// TableView의 Cell이 선택되었을 때 동작하는 메서드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
        let isAdvertisement = travelArray[indexPath.row].ad
        
        switch isAdvertisement {
        case true:
            print("광고")
        case false:
            pushToTouristAttractionViewController(with: travelArray[indexPath.row])
        }
    }
}
