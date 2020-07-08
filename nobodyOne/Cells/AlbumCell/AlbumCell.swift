//
//  AlbumCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class AlbumCell: BaseCell {
    
    public var album: Album? {
        didSet {
            self.setupCell()
        }
    }

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var songsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
        self.yearLabel.text = nil
        self.albumTitleLabel.text = nil
        self.songsCountLabel.text = nil
    }
    
    override func setupCell() {
        guard let album = album else { return }
        if let name = album.coverImageName { self.coverImageView.image = UIImage(named: name) }
        self.yearLabel.text = album.year?.description
        self.albumTitleLabel.text = album.title
        self.songsCountLabel.text = "Песен" + ": \(album.songs?.count ?? 0)"
    }
    
}
