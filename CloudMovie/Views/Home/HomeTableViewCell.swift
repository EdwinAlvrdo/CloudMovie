//
//  HomeTableViewCell.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/12/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    let playerViewController = AVPlayerViewController()
    
    var data: PackMoviesDTO!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.registerCell()
    }
    
    func registerCell() {
        self.collectionView.register(UINib.init(nibName: "ThumbCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "thumbCell")
        
        self.collectionView.register(UINib.init(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "posterCell")
    }
    
    func setup(_ data: PackMoviesDTO){
        self.data = data
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func playVideoWithController(urlString: String){
        
        let videoURL = NSURL(string: urlString)
        let player = AVPlayer(url: videoURL! as URL)

        playerViewController.player = player
        playerViewController.showsPlaybackControls = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(playerViewController, animated: true) {
                self.playerViewController.player!.play()
            }
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.playerViewController.dismiss(animated: true)
    }

}

extension HomeTableViewCell:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (data.type?.elementsEqual("thumb"))! {
            return CGSize(width: self.collectionView.bounds.width * 0.80, height: self.collectionView.bounds.height * 0.90)
        }else{
            return CGSize(width: self.collectionView.bounds.width * 0.60, height: self.collectionView.bounds.height * 0.90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        var item: MoviesDTO = data.items![indexPath.row]
        
        if (data.type?.elementsEqual("thumb"))! {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbCell", for: indexPath) as! ThumbCollectionViewCell
            (cell as! ThumbCollectionViewCell).setup(item)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterCollectionViewCell
            (cell as! PosterCollectionViewCell).setup(item)
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: MoviesDTO = data.items![indexPath.row]
        
        if let mVideoUrlString = item.videoUrl, !mVideoUrlString.isEmpty {
            self.playVideoWithController(urlString: mVideoUrlString)
        }else{
            Utils.View.showMessage(title: "Ups!", message: "Video no disponible")
        }
    }
    
}
