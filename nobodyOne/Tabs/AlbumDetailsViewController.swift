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
        
    public var album: Album? {
        didSet {
            setupViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupYoutubeView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnAppleMusicButton(_ sender: Any) {
        guard let appleMusicUrl = self.album?.appleMusicUrl else { return }
        UIApplication.shared.open(appleMusicUrl)
    }
    
    fileprivate func setupYoutubeView() {
        // Create a new player
        guard let videoID = self.album?.videoId else { return }
        youtubeView.playerVars = ["playsinline": "1", "controls": "0", "fs": "0", "showinfo": "0"] as [String: AnyObject]
        youtubeView.loadVideoID(videoID)
        youtubeView.delegate = self
    }
    
    fileprivate func setupViews() {
        self.setNavigationTitle(album?.title ?? "Album")
    }

}

extension AlbumDetailsViewController: YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("Player Ready!")
        videoPlayer.play()
    }
    
}

