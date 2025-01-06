//
//  PopularCityTableViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/6/25.
//

import UIKit

final class PopularCityTableViewController: UITableViewController {
    
    private let originalCityArray: [City] = CityInfo().city
    private var cityArray: [City] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet var countrySegmentedControl: UISegmentedControl!
    @IBOutlet var searchCountryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupHeaderView()
        setupTableView()
        countrySegmentValueDidChange(countrySegmentedControl)
    }
    
    /// Navigation 설정하는 메서드
    private func setupNavigation() {
        title = "인기 도시"
    }
    
    /// headerView 프로퍼티 속성을 설정하는 메서드
    private func setupHeaderView() {
        countrySegmentedControl.setTitle("모두", forSegmentAt: 0)
        countrySegmentedControl.setTitle("국내", forSegmentAt: 1)
        countrySegmentedControl.setTitle("해외", forSegmentAt: 2)
        
        searchCountryTextField.placeholder = "찾으시는 내용을 검색해주세요."
        searchCountryTextField.borderStyle = .roundedRect
        searchCountryTextField.textColor = .black
    }
    
    /// TableView 속성 설정하는 메서드
    private func setupTableView() {
        let uiNib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
    }
    
    /// 도시 변경 SegmentedControl Value가 변경되었을 때 호출되는 메서드
    @IBAction func countrySegmentValueDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            cityArray = originalCityArray
        } else if sender.selectedSegmentIndex == 1 {
            cityArray = originalCityArray.filter { $0.domestic_travel }
        } else {
            cityArray = originalCityArray.filter { !$0.domestic_travel }
        }
    }
}

extension PopularCityTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PopularCityTableViewCell.identifier,
            for: indexPath
        ) as? PopularCityTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(cityArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
