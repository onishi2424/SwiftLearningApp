//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    //MARK: Properties
//    var weatherManager = WeatherDataManager()
//    var jokeManeger = JokeDataManater()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
//        weatherManager.delegate = self
//        jokeManeger.delegate = self
        searchField.delegate = self
        
        // 次の画面のBackボタンを「戻る」に変更
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:  "",
                                                                style:  .plain,
                                                                target: nil,
                                                                action: nil)
        jokeLabel.text = "Dad Jokをタップ！"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UINavigationBarの透明化設定
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // 背景を透明に
        appearance.backgroundColor = .clear // 背景色をクリアに設定
        appearance.shadowColor = .clear // シャドウをクリアに設定
        self.navigationItem.hidesBackButton = false

        // 現在のナビゲーションバーに反映
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    @IBAction func tappedFavoriteButton(_ sender: UIButton) {
        
        let favoriteVC = FavoriteViewController(nibName: "FavoriteViewController",
                                                bundle: nil)
        
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    @IBAction func tappedJokeButton(_ sender: UIButton) {
        ModelService.shared.jokeModel.callJoke2() { result, error in
            if error != nil || result == nil {
                self.jokeLabel.text = ""
                return
            }
            
            self.jokeLabel.text = result!.joke
        }
    }
}
 
//MARK:- TextField extension
extension WeatherViewController: UITextFieldDelegate {
    
        @IBAction func searchBtnClicked(_ sender: UIButton) {
            searchField.endEditing(true)    //dismiss keyboard
            print(searchField.text!)
            
            guard let cityName = searchField.text else { return }
            
            self.updateCityWeather(cityName: cityName)
        }
    
        func updateCityWeather(cityName: String) {
            ModelService.shared.cityModel.callCity(q: cityName){ result, error in
                if error != nil || result == nil {
                    return
                }
                
                self.temperatureLabel.text = result!.temperatureString
                self.cityLabel.text = result!.cityName
                if let conditionName = result!.conditionName {
                    self.conditionImageView.image = UIImage(systemName: conditionName)
                }
                
                if result!.cityName == "Tokyo" {
                    //Tokyoの場合、夕暮れの背景
                    self.backgroundImageView.image = UIImage(named: "darkBackground")
                } else {
                    //Tokyoでない場合、デフォルト背景
                    self.backgroundImageView.image = UIImage(named: "background")
                }
                //コンソールにログを出力する
                print("action: search, city: \(result!.cityName ?? "")")
            }
        }
    
        func updateLocalWeather(lat: Double, lon: Double) {
            ModelService.shared.localModel.callLocal(lat: lat, lon: lon) { result, error in
                if error != nil || result == nil {
                    return
                }
                
                self.temperatureLabel.text = result!.temperatureString
                self.cityLabel.text = result!.cityName
                if let conditionName = result!.conditionName {
                    self.conditionImageView.image = UIImage(systemName: conditionName)
                }
                
                if result!.cityName == "Tokyo" {
                    //Tokyoの場合、夕暮れの背景
                    self.backgroundImageView.image = UIImage(named: "darkBackground")
                } else {
                    //Tokyoでない場合、デフォルト背景
                    self.backgroundImageView.image = UIImage(named: "background")
                }
                //コンソールにログを出力する
                print("action: search, city: \( result!.cityName ?? "")")
            }
        }
        
        // when keyboard return clicked
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchField.endEditing(true)    //dismiss keyboard
            print(searchField.text!)
            
            updateCityWeather(cityName: searchField.text ?? "")
            return true
        }
        
        // when textfield deselected
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            // by using "textField" (not "searchField") this applied to any textField in this Controller(cuz of delegate = self)
            if textField.text != "" {
                return true
            }else{
                textField.placeholder = "Type something here"
                return false            // check if city name is valid
            }
        }
        
        // when textfield stop editing (keyboard dismissed)
        func textFieldDidEndEditing(_ textField: UITextField) {
    //        searchField.text = ""   // clear textField
        }
}

// MARK:- CLLocation
extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationButtonClicked(_ sender: UIButton) {
        // Get permission
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            updateLocalWeather(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
