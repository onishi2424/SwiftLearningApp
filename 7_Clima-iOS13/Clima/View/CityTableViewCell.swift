//
//  CityCellTableViewCell.swift
//  Clima
//
//  Created by 大西志織 on 2025/01/10.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    var entity: CityName? {
        didSet {
            setCity()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCity() {
        guard let city = entity else {return}
        self.cityLabel.text = city.jpName
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
