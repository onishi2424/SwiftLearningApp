//
//  FavoriteViewController.swift
//  Clima
//
//  Created by 大西志織 on 2024/10/18.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "newTitle"
        self.navigationItem.hidesBackButton = false
        ColorUtil.changeNavigationBarColor(.navigationHeaderColor)
    }
}
