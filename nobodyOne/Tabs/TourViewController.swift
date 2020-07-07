//
//  TourViewController.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class TourViewController: BaseViewController {
    
    private var tours = [Tour]()
    private var concertCellId = "ConcertCell"

    @IBOutlet weak var tourTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tourTableView.register(UINib(nibName: "ConcertCell", bundle: nil), forCellReuseIdentifier: concertCellId)
        self.loadEvents()
    }
    
    fileprivate func openTicketsWebsite(_ concert: Concert?) {
        if let url = concert?.ticketsUrl {
            UIApplication.shared.open(url)
        }
    }
    
    fileprivate func loadEvents() {
        self.activityIndicator.startAnimating()
        self.servicesContainer.concertService?.getConcerts(completed: { [weak self] (tours) in
            self?.tours = tours
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tourTableView.reloadData()
            }
        }, failure: { [weak self] (err) in
            self?.handleError(err)
        })
    }


}

extension TourViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 2, width: 320, height: 26)
        myLabel.font = UIFont(name: "Ubuntu-Bold", size: 18)
        myLabel.text = tours[section].title
        myLabel.textColor = .white

        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "BackgroundColor")
        headerView.addSubview(myLabel)

        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tours.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours[section].concerts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: concertCellId) as! ConcertCell
        cell.delegate = self
        cell.concert = tours[indexPath.section].concerts?[indexPath.row]
        return cell
    }
}

extension TourViewController: ConcertCellDelegate {
    func didTapOnPurchaseTicket(_ concert: Concert?) {
        self.openTicketsWebsite(concert)
    }
    
    
}

