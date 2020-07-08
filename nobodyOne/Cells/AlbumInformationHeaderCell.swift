//
//  AlbumInformationHeaderCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 08.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class AlbumInformationHeaderCell: BaseCell {
    
    public var isExpanded: Bool = true {
        didSet {
            self.arrowImageView.image = isExpanded ? UIImage(named: "arrow-bottom") : UIImage(named: "arrow-top")
        }
    }
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.arrowImageView.image = UIImage(named: "arrow-bottom")
    }
    
}
