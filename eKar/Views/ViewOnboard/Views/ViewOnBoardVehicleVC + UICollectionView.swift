//
//  ViewOnBoardVehicleVC + UICollectionView.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

//MARK: - CollectionView Delegate and Datasource methods
extension ViewOnBoardVehicleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.vehicleList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadVehicleImageCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as! UploadVehicleImageCollectionViewCell
        
        cell.configureCell(viewOnBoardModel: viewModel.vehicleList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        let height = collectionView.bounds.height / 2
        return CGSize(width: width - 20, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedIndex = indexPath.row
        self.openOptionsForImage(message: LocalizedKey.openImageOptions.string,sender: collectionView)
    }
    
    
}

