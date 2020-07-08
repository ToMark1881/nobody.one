//
//  MediaCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 08.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class MediaCell: BaseCell {
    
    public var media: Media? {
        didSet {
            setupCell()
        }
    }

    @IBOutlet weak var mediaTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupCell() {
        guard let media = media else { return }
        self.mediaTitleLabel.text = media.title ?? ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mediaTitleLabel.text = nil
    }
    
}
