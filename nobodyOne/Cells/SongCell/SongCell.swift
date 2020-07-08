//
//  SongCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 08.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class SongCell: BaseCell {
    
    public var song: Song? {
        didSet {
            setupCell()
        }
    }

    @IBOutlet weak var songPositionLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.songPositionLabel.text = nil
        self.songNameLabel.text = nil
    }
    
    override func setupCell() {
        guard let song = song else { return }
        self.songPositionLabel.text = song.position?.description ?? "0"
        self.songNameLabel.text = song.title
    }
    
}
