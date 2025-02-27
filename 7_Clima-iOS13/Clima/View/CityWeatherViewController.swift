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
    var weatherManager = WeatherDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        if let cityName = cityName {
            self.navigationItem.title = cityName.jpName
            weatherManager.fetchWeather(cityName.enName)
        }
    }
}

extension CityWeatherViewController: WeatherManagerDelegate {

    func updateWeather(weatherModel: WeatherModel){
        DispatchQueue.main.sync {
            self.weatherImage.image = UIImage(systemName: weatherModel.conditionName)
            tempratureLabel.text = weatherModel.temperatureString
            cityNameLabel.text = weatherModel.cityName
        }
    }
    
    func failedWithError(error: any Error) {
        print(error)
    }
}
