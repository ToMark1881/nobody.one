//
//  ConcertCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class ConcertCell: BaseCell {
    
    public var concert: Concert? {
        didSet {
            setupCell()
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    
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
        self.dateLabel.text = nil
        self.placeLabel.text = nil
    }
    
    override func setupCell() {
        guard let concert = concert else { return }
        self.placeLabel.text = "\(concert.city ?? "") / \(concert.placeTitle ?? "")"
        self.dateLabel.text = concert.getFormattedDate()
    }
    
}
