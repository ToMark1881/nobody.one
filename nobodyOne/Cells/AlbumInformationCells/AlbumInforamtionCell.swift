//
//  AlbumInforamtionCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 08.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class AlbumInforamtionCell: BaseCell {
    
    public var album: Album? {
        didSet {
            setupCell()
        }
    }

    @IBOutlet weak var informationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setupCell() {
        guard let album = album else { return }
        self.informationLabel.text = album.additionalInfo ?? ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.informationLabel.text = nil
    }
    
}
