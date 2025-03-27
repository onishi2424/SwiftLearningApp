//
//  CityWeatherViewController.swift
//  Clima
//
//  Created by 大西志織 on 2025/01/16.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityName: CityName?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let cityName = cityName {
            self.navigationItem.title = cityName.jpName
            ModelService.shared.cityModel.callCity(q: cityName.enName) { result, error in
                if error != nil || result == nil {
                    return
                }
                
                if result!.conditionName != nil {
                    self.weatherImage.image = UIImage(systemName: result!.conditionName!)
                }
                self.tempratureLabel.text = result!.temperatureString
                self.cityNameLabel.text = result!.cityName
            }
        }
    }
}
