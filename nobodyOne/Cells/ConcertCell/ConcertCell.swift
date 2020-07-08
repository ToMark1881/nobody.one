//
//  ConcertCell.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

protocol ConcertCellDelegate: class {
    
    func didTapOnPurchaseTicket(_ concert: Concert?)
    
}

import UIKit

class ConcertCell: BaseCell {
    
    public var concert: Concert? {
        didSet {
            setupCell()
        }
    }
    
    weak var delegate: ConcertCellDelegate?

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didTappedOnBuyTicketsButton(_ sender: Any) {
        self.delegate?.didTapOnPurchaseTicket(self.concert)
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
        if let timestamp = concert.eventTimestamp {
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru")
            dateFormatter.dateFormat = "d MMMM"
            self.dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
}
