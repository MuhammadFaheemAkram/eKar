//
//  KeyFeaturesCollectionViewCell.swift
//  ekar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class KeyFeatureTableViewCell: BaseTableViewCell {

    //MARK: Properties
    private var features = [String]()
    
    //MARK: Outlets
    @IBOutlet weak var collectionViewHeightCnst: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView?.register(UINib(nibName: KeyFeaturesCollectionViewCell.reuseIdentifier, bundle: nil),
                                     forCellWithReuseIdentifier: KeyFeaturesCollectionViewCell.reuseIdentifier)
        }
    }
    
    var reloadView: (() -> ())?
    
    func configureCell(keyFeatures: [String]) {
        if features.count == 0 {
            features = keyFeatures
            self.collectionView.reloadData()
            GCD.async(.Main, delay: 1.0) {
                self.collectionViewHeightCnst.constant = self.collectionView.contentSize.height
                self.reloadView?()
            }
        }
    }
    
}

//MARK: - CollectionView Delegate
extension KeyFeatureTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyFeaturesCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as! KeyFeaturesCollectionViewCell
        
        cell.featureLabel.text = features[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let feature = features[indexPath.row]
        let itemSize = feature.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 10)
        ])
        return CGSize(width: itemSize.width + 10, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
