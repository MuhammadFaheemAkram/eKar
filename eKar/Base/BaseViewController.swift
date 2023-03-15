//
//  BaseViewController.swift
//  Point City
//
//  Created by Faheem on 01/05/2020.
//  Copyright © 2020 Crymzee Networks. All rights reserved.
//

import UIKit
import SDWebImage

public class BaseViewController : UIViewController,
                                  UINavigationControllerDelegate,
                                  UIImagePickerControllerDelegate {
    
    lazy var profileImagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkInternetConnection() -> Bool {
        if(BReachability.isConnectedToNetwork()){
            return true
        } else {
            showAlertView(message: LocalizedKey.noInternet.string)
            return false
        }
    }
    
	
    func openOptionsForImage(message: String = kBlankString,
                           sender: UIView){
       let actionSheet = UIAlertController.init(title: kBlankString, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: LocalizedKey.camera.string, style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                self.profileImagePicker.sourceType = .camera
                self.present(self.profileImagePicker, animated: true, completion:  nil)
            } else {
                print("Camera is not available")
            }
        }))
        actionSheet.addAction(UIAlertAction.init(title: LocalizedKey.photos.string, style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.profileImagePicker.sourceType = .photoLibrary
            self.present(self.profileImagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction.init(title: LocalizedKey.cancel.string, style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
        }))
        actionSheet.popoverPresentationController?.sourceView = sender
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.profileImagePicker.dismiss(animated: true, completion: nil)
    }
    
    func showAlertVIew(message:String, title:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: LocalizedKey.ok.string, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showLoader(_ show: Bool) {
        show ? LoaderManager.show(view) : LoaderManager.hide(view)
    }
    
    //MARK: SetImageWithUrl
    func setImageWithUrl(imageView: UIImageView, url: String, placeholder: String = ""){
        let finalUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let imageurl =  URL(string: url){
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: imageurl, placeholderImage: UIImage(named: placeholder))
        } else if let imageurl =  URL(string: finalUrl){
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: imageurl, placeholderImage: UIImage(named: placeholder))
        } else {
            imageView.image = UIImage(named: placeholder)
        }
    }
    func showAlertView(message:String) {
        showAlertView(message: message, title: ALERT_APP_TITLE)
    }
    
    func showAlertView(message:String, title:String, doneButtonTitle:String, doneButtonCompletion: ((UIAlertAction) -> Void)?) {
        showAlertView(message: message, title: title, doneButtonTitle: doneButtonTitle, doneButtonCompletion: doneButtonCompletion, cancelButtonTitle: nil, cancelButtonCompletion: nil)
    }
    
    func showAlertView(message:String, title:String, doneButtonTitle:String = LocalizedKey.ok.string, doneButtonCompletion: ((UIAlertAction) -> Void)? = nil, cancelButtonTitle:String? = nil, cancelButtonCompletion:((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: doneButtonTitle, style: .default, handler: doneButtonCompletion)
        if let cancelTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelButtonCompletion)
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func buildAlertSheet(with title:String? = nil, message:String? = nil, options:[String], completion: @escaping (Int,String)->Void) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for index in 0..<options.count {
            let action = UIAlertAction(title: options[index], style: .default) { (_) in
                completion(index,options[index])
            }
            
            controller.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: LocalizedKey.cancel.string, style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        self.present(controller, animated: true, completion: nil)
    }
    
    func addTapToDismissForView(_ view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDissmiss(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func tapToDissmiss(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
