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
    private let sectionInsets = UIEdgeInsets(top: 50.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0)
    
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
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileFactory: ProfileFactory = ProfileFactory()
        profileFactory.getProfiles { [weak self] (profiles, error) in
            guard let strongSelf = self else { return }
            strongSelf.profiles = profiles
            DispatchQueue.main.async {
                strongSelf.collectionView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      return CGSize(width: widthPerItem, height: widthPerItem)
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

