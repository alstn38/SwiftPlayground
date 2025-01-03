//
//  MagazineViewController.swift
//  MSTravel
//
//  Created by 강민수 on 1/3/25.
//

import UIKit

final class MagazineTableViewController: UITableViewController {

    private var magzineArray = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    /// 네비게이션 설정하는 메서드
    private func setupNavigation() {
        title = "MS TRAVEL"
    }
}

extension MagazineTableViewController {
    
    /// TableView의 Row의 개수를 반환하는 메서드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magzineArray.count
    }
    
    /// TableView의 Row별 Cell 반환하는 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "MagazineTableViewCell",
            for: indexPath
        ) as? MagazineTableViewCell else {
            return UITableViewCell()
        }
        
        let row = magzineArray[indexPath.row]
        cell.configureCell(row)
        
        return cell
    }
}
