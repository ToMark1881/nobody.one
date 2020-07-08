//
//  BaseCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.init(named: "ConcertCellColor")
        self.selectedBackgroundView = bgColorView
        // Configure the view for the selected state
    }
    
    func setupCell() {
        // For override
    }

}
