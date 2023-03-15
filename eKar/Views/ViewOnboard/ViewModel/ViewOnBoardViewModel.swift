//
//  ViewOnBoardViewModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class ViewOnBoardViewModel {
    
    //MARK: Properties
    private(set) var vehicleList = [ViewOnBoardModel]()
    var selectedIndex: Int?
    var comments: String = kBlankString
    var showAlert = Bindable<Alert>((kBlankString,kBlankString))
    
    //MARK: Init Methods
    init() {
        setListData()
    }
    
    //MARK: Public Methods
    func updateSelectedImage(image: UIImage) {
        guard let index = selectedIndex else { return }
        vehicleList[index].selectedImage = image
    }
    
    ///Calls when user clicks on submit button
    func submitTapped(){
        if vehicleList.first(where: {$0.selectedImage == nil}) != nil {
            showAlert.value = (ALERT_APP_TITLE, LocalizedKey.uploadImagesError.string)
        } else if comments.isEmpty {
            showAlert.value = (ALERT_APP_TITLE, LocalizedKey.commentsError.string)
        } else {
            showAlert.value = (ALERT_APP_TITLE, LocalizedKey.thankYouMessege.string)
        }
    }
}

//MARK: Private Methods
private extension ViewOnBoardViewModel {
    
    ///Sets a new list with requried data
    private func setListData() {
        vehicleList.append(ViewOnBoardModel(label: LocalizedKey.frontLeft.string, placeholderImage: Image.frontLeft))
        vehicleList.append(ViewOnBoardModel(label: LocalizedKey.frontRight.string, placeholderImage: Image.frontRight))
        vehicleList.append(ViewOnBoardModel(label: LocalizedKey.backLeft.string, placeholderImage: Image.backLeft))
        vehicleList.append(ViewOnBoardModel(label: LocalizedKey.backRight.string, placeholderImage: Image.backRight))
    }
}
