//
//  ViewController.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/11/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var profiles: [Profile]?
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 30.0,
                                             left: 26.0,
                                             bottom: 30.0,
                                             right: 26.0)
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let profiles = self.profiles else {
            return 0
        }
        return profiles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let cellProfile = self.profiles?[indexPath.row] {
            cell.profile = cellProfile
        }
        
        cell.contentView.layer.cornerRadius = 5
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        //self.setNeedsStatusBarAppearanceUpdate()
        let profileFactory: ProfileFactory = ProfileFactory()
        profileFactory.getProfiles { [weak self] (profiles, error) in
            guard let strongSelf = self else { return }
            strongSelf.profiles = profiles
            DispatchQueue.main.async {
                strongSelf.collectionView.reloadData()
                strongSelf.collectionView.layoutIfNeeded()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
        
      return CGSize(width: widthPerItem, height: 333)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}
