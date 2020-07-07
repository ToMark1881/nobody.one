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
    
}

