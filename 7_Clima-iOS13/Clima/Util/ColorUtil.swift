//
//  ColorUtil.swift
//  Clima
//
//  Created by 大西志織 on 2024/10/18.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import Foundation

class ColorUtil {
    
    // NavigationBarの背景色を保存するためのUserdDefaults
    static let navigationBarColorData: UserDefaults = UserDefaults.standard
    static func changeNavigationBarColor(_ barColor: UIColor) {
            
        let appearance = UINavigationBarAppearance()
        // ここでタップしたボタンの色と同じ色をNavigationBarの色にする
        appearance.backgroundColor = barColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance // iOS 15以降の場合
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // iOS 15以降の場合
        
        // すべてのナビゲーションバーを更新
        UINavigationBar.appearance().tintColor = UIColor.black
        if #available(iOS 13.0, *) {
            // ここでタップしたボタンの色と同じ色をNavigationBarの色にする
            UINavigationBar.appearance().barTintColor = barColor
        } else {
            // ここでタップしたボタンの色と同じ色をNavigationBarの色にする
            UINavigationBar.appearance().barTintColor = barColor
        }
        
        // 既存のナビゲーションバーに変更を反映させる
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
        
        // UIColorを文字列に変換
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: barColor, requiringSecureCoding: false) {
            let colorString = colorData.base64EncodedString()
            
            // UserDefaultsにナビゲーションバーの背景色を文字列で保存する
            navigationBarColorData.set(colorString, forKey: "navigationBarColor")
            
        }
    }

}
