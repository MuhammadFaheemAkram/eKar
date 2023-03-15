//
//  VehicleImageTableViewCell.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit
import SDWebImage

class VehicleImageTableViewCell: BaseTableViewCell {
    
    //MARK: Properties
    private var images = [ImageModel]()
    
    //MARK: Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!


    //MARK: Configure Cell
    func configureCell(images: [ImageModel]) {
        collectionView.backgroundColor = Colors.primaryColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: VehicleImageCollectionViewCell.reuseIdentifier, bundle: nil),
                                 forCellWithReuseIdentifier: VehicleImageCollectionViewCell.reuseIdentifier)
        self.images = images
        collectionView.reloadData()
    }
}


//MARK: CollectionView Delegate
extension VehicleImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = collectionView.frame.width
        let currentPage = Int((collectionView.contentOffset.x + width / 2) / width)
        pageControl.currentPage = currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = self.images.count
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleImageCollectionViewCell.reuseIdentifier,
                                                           for: indexPath) as! VehicleImageCollectionViewCell
        
        cell.setImage(url: images[indexPath.row].link)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
