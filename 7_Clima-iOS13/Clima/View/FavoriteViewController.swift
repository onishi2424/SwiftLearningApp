//
//  FavoriteViewController.swift
//  Clima
//
//  Created by 大西志織 on 2024/10/18.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

struct rail {
    var isShown: Bool
    var railName: String
    var stationArray: [CityName]
}

class FavoriteViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private let headerArray: [String] = ["EU", "アジア", "オセアニア", "アフリカ"]
    private let yamanoteArray: [CityName] = [CityName(jpName: "ベルリン", enName: "Berlin"),
                                             CityName(jpName: "アムステルダム", enName: "Amsterdam"),
                                             CityName(jpName: "ロンドン", enName: "London")]
    private let toyokoArray: [CityName] = [CityName(jpName: "東京", enName: "Tokyo"),
                                            CityName(jpName: "バンコク", enName: "Bangkok")]
    private let dentoArray: [CityName] = [CityName(jpName: "シドニー", enName: "Sydney"),
                                          CityName(jpName: "メルボルン", enName: "Melbourne")]
    private let jobanArray: [CityName] = [CityName(jpName: "ケープタウン", enName: "Cape Town")]

    private lazy var courseArray = [
        rail(isShown: true, railName: self.headerArray[0], stationArray: self.yamanoteArray),
        rail(isShown: true, railName: self.headerArray[1], stationArray: self.toyokoArray),
        rail(isShown: true, railName: self.headerArray[2], stationArray: self.dentoArray),
        rail(isShown: true, railName: self.headerArray[3], stationArray: self.jobanArray)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        self.navigationItem.title = "都市一覧"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        self.navigationItem.hidesBackButton = false
        ColorUtil.changeNavigationBarColor(R.color.navigationHeaderColor()!)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray[section].isShown ? courseArray[section].stationArray.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.entity = courseArray[indexPath.section].stationArray[indexPath.row]
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return courseArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return courseArray[section].railName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath,animated:true)
        let word = courseArray[indexPath.section].stationArray[indexPath.row]
        let cityVC = CityWeatherViewController(nibName: "CityWeatherViewController",
                                                   bundle: nil)
        cityVC.cityName = word
        navigationController?.pushViewController(cityVC, animated: true)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        
        headerView.contentView.backgroundColor = .systemGray6
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(headertapped(sender:)))
        headerView.backgroundView?.backgroundColor = .lightGray
        headerView.addGestureRecognizer(gesture)
        headerView.tag = section
        return headerView
    }

    @objc func headertapped(sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else {
            return
        }
        courseArray[section].isShown.toggle()
        
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
}
