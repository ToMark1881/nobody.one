//
//  ConcertViewController.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 16.08.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class ConcertViewController: BaseViewController {
    
    @IBOutlet weak var tourImageView: UIImageView!
    @IBOutlet weak var concertDateLabel: UILabel!
    @IBOutlet weak var concertCityLabel: UILabel!
    @IBOutlet weak var buyTicketsButton: UIButton!
    @IBOutlet weak var concertPlaceLabel: UILabel!
    @IBOutlet weak var concertPlaceMapView: MKMapView!
    @IBOutlet weak var openNavigationButton: UIButton!
    @IBOutlet weak var tourInfoLabel: UILabel!
    
    
    public var concert: Concert?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func didTappedOnBuyTicketsButton(_ sender: Any) {
        self.servicesContainer.analyticsService?.trackOpenTicketsStore(concert?.city)
        self.openTicketsWebsite(self.concert)
    }
    
    @IBAction func didTappedOnOpenNavigationButton(_ sender: Any) {
        self.openMapNavigation()
    }
    
    override func setupViews() {
        guard let concert = self.concert else { return }
        self.setNavigationTitle(concert.city ?? "Concert".localized)
        self.concertDateLabel.text = concert.getFormattedDate()
        self.concertCityLabel.text = (concert.city ?? "").uppercased()
        self.concertPlaceLabel.text = concert.placeTitle ?? ""
        self.tourInfoLabel.text = concert.tour?.tourInfo ?? ""
        if let url = concert.tourImageUrl {
            self.tourImageView.kf.setImage(with: url)
        }
        self.setupMap(concert)
    }
    
    fileprivate func setupMap(_ concert: Concert) {
        guard let point = concert.mapPoint, let location = point.location else { return }
        let mapArtwork = Artwork(title: concert.placeTitle ?? "nobody.one", locationName: "nobody.one", discipline: "Concert".localized, coordinate: location.coordinate)
        self.concertPlaceMapView.addAnnotation(mapArtwork)
        self.concertPlaceMapView.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
    }
    
    fileprivate func openMapNavigation() {
        guard let concert = self.concert else { return }
        guard let point = concert.mapPoint, let location = point.location else { return }
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
        destination.name = concert.placeTitle ?? "Concert".localized
        
        MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    fileprivate func openTicketsWebsite(_ concert: Concert?) {
        if let url = concert?.ticketsUrl {
            UIApplication.shared.open(url)
        }
    }
    
    deinit {
        print("deinit ConcertViewController")
    }

}
