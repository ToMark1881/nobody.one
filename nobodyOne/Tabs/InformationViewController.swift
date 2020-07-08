//
//  InformationViewController.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class InformationViewController: BaseViewController {
    
    var mediaObjects = [Media]()
    
    private let mediaCellId = "MediaCellId"

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mediaTableView: UITableView!
    @IBOutlet weak var mediaTableViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaTableView.register(UINib(nibName: "MediaCell", bundle: nil), forCellReuseIdentifier: mediaCellId)
        loadMedia()
    }
    
    fileprivate func loadMedia() {
        self.servicesContainer.mediaService?.getMedia(completed: { [weak self] (mediaObjects) in
            self?.mediaObjects = mediaObjects
            DispatchQueue.main.async {
                self?.mediaTableView.reloadData()
                self?.mediaTableViewHeight.constant = self?.mediaTableView.contentSize.height ?? 0
            }
        }, failure: { [weak self] (err) in
            self?.handleError(err)
        })
    }
    
    
    fileprivate func openMedia(_ media: Media) {
        if let app = media.appUrl, UIApplication.shared.canOpenURL(app) {
            UIApplication.shared.open(app)
        } else if let safari = media.safariUrl, UIApplication.shared.canOpenURL(safari) {
            UIApplication.shared.open(safari)
        }
        
    }
    @IBAction func didTapOnWriteToDeveloperButton(_ sender: Any) {
        guard let url = URL(string: "mailto:vlad182ava@gmail.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url) }
    }
    @IBAction func didTapOnWebsiteButton(_ sender: Any) {
        guard let url = URL(string: "http://nobody.one") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url) }
    }
}

extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMedia(self.mediaObjects[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mediaCellId) as! MediaCell
        cell.media = self.mediaObjects[indexPath.row]
        return cell
    }
    
    
}
