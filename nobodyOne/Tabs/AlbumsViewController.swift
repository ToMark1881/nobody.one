//
//  AlbumsViewController.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit

class AlbumsViewController: BaseViewController {
    
    var albums =  [Album]()
    private let albumCellId = "AlbumCell"

    @IBOutlet weak var albumsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsTableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: albumCellId)
        loadAlbums()
    }
    
    fileprivate func loadAlbums() {
        self.servicesContainer.albumsSerive?.getAlbums(completed: { [weak self] (albums) in
            self?.albums = albums
            DispatchQueue.main.async {
                self?.albumsTableView.reloadData()
            }
        }, failure: { [weak self] (err) in
            self?.handleError(err)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showAlbumDetailsViewController", let album = sender as? Album {
            let albumViewController = segue.destination as? AlbumDetailsViewController
            albumViewController?.album = album
        }
    }


}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: albumCellId) as! AlbumCell
        cell.album = albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showAlbumDetailsViewController", sender: albums[indexPath.row])
    }
    
}

