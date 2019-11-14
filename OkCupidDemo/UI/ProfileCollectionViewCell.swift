//
//  ProfileCollectionViewCell.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/12/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import UIKit
import OKImageDownloader

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var isOnlineView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ageLocationLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    
    
    
    var profile: Profile? {
        didSet {
            if let profile = profile {
                userNameLabel.text = profile.userName
                ageLocationLabel.text = "\(profile.age) • \(profile.location.cityName), \(profile.location.stateCode)"
                matchLabel.text = "\(profile.match/100)% Match"
                isOnlineView.layer.cornerRadius = isOnlineView.frame.size.width/2
                isOnlineView.isHidden = (profile.isOnline == 0)
                if let imageURL = URL(string: profile.photo.medium) {
                    profileImageView.downloadImage(with: imageURL, completionHandler: nil)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.profileImageView.cancelDownloadImage()
        self.profileImageView.image = nil
    }
    
    deinit {
        self.profileImageView.cancelDownloadImage()
    }
    
}
