//
//  AlbumDetailsViewController.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import UIKit
import YouTubePlayer

class AlbumDetailsViewController: BaseViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    @IBOutlet weak var appleMusicButton: UIButton!
    @IBOutlet weak var albumTableView: UITableView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    private let songCellId = "SongCell"
    private let informationHeaderCellId = "informationHeaderCell"
    private let informationCellId = "informationCell"

    fileprivate var isExpanded = true
    fileprivate var isPlaying = false
    
    public var album: Album? {
        didSet {
            setupViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupYoutubeView()
        setupTableView()
    }
    
    deinit {
        print("deinit AlbumDetailsViewController")
    }
    
    @IBAction func didTapOnAppleMusicButton(_ sender: Any) {
        guard let appleMusicUrl = self.album?.appleMusicUrl else { return }
        self.servicesContainer.analyticsService?.trackAlbumOpenedInAppleMusic(self.album?.title)
        UIApplication.shared.open(appleMusicUrl)
    }
    
    @IBAction func didTappedOnPlayPauseButton(_ sender: Any) {
        if isPlaying { self.youtubeView.pause() } else { self.youtubeView.play() }
    }
    @IBAction func didTappedOnOpenYoutubeButton(_ sender: Any) {
        guard let videoID = self.album?.videoId, let videoUrl = self.album?.youtubeUrl else { return }
        //youtube://www.youtube.com/user/stereodamage
        if let appUrl = URL(string: "youtube://youtu.be/\(videoID)"), UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl)
        } else if UIApplication.shared.canOpenURL(videoUrl) { UIApplication.shared.open(videoUrl) }
    }
    
    @IBAction func didTappedOnSpotifyButton(_ sender: Any) {
        guard let spotyfyUrl = self.album?.spotifyUrl else { return }
        if let appUrl = URL(string: "spotify://\(spotyfyUrl.absoluteString)"), UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl)
        } else if UIApplication.shared.canOpenURL(spotyfyUrl) { UIApplication.shared.open(spotyfyUrl) }
    }
    
    fileprivate func setupYoutubeView() {
        // Create a new player
        guard let videoID = self.album?.videoId else { return }
        youtubeView.playerVars = ["playsinline": "1", "controls": "0", "fs": "0", "showinfo": "0"] as [String: AnyObject]
        youtubeView.loadVideoID(videoID)
        youtubeView.delegate = self
    }
    
    fileprivate func setupTableView() {
        albumTableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: songCellId)
        albumTableView.register(UINib(nibName: "AlbumInforamtionCell", bundle: nil), forCellReuseIdentifier: informationCellId)
        albumTableView.register(UINib(nibName: "AlbumInformationHeaderCell", bundle: nil), forCellReuseIdentifier: informationHeaderCellId)
        albumTableView.reloadData()
        setupTableViewHeight()
    }
    
    fileprivate func setupTableViewHeight() {
        self.tableHeight.constant = self.albumTableView.contentSize.height + 12
        self.mainScrollView.layoutIfNeeded()
    }
    
    fileprivate func setupViews() {
        self.setNavigationTitle(album?.title ?? "Album")
    }
    
    fileprivate func scrollToSong(_ song: Song?) {
        guard let song = song, let timestamp = song.timestamp else { return }
        let second: Float = Float(timestamp)
        self.youtubeView.seekTo(second, seekAhead: true)
    }

}

extension AlbumDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 { //expandCell
            self.isExpanded.toggle()
            self.albumTableView.reloadSections(IndexSet(integersIn: 0...0), with: .fade)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.setupTableViewHeight()
            }
        } else if indexPath.section == 1 { //songTapped
            let song = self.album?.songs?[indexPath.row]
            self.servicesContainer.analyticsService?.trackSelectedSong(song?.title)
            self.scrollToSong(song)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
           return album?.songs?.count ?? 0
        }
        else {
            return isExpanded ? 1 : 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: songCellId) as! SongCell
            cell.song = album?.songs?[indexPath.row]
            return cell
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: informationHeaderCellId) as! AlbumInformationHeaderCell
                cell.isExpanded = self.isExpanded
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: informationCellId) as! AlbumInforamtionCell
                cell.album = self.album
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}

extension AlbumDetailsViewController: YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("Player Ready!")
        self.playAndPauseButton.isEnabled = true
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if playerState == .Playing {
            self.isPlaying = true
        } else if playerState == .Paused {
            self.isPlaying = false
        }
        let playerButtonImage = self.isPlaying ? UIImage(named: "player-pause") : UIImage(named: "player-play")
        self.playAndPauseButton.setImage(playerButtonImage, for: .normal)
    }
    
}

