//
//  BaseTableViewCell.swift
//  KMRA-iOS
//
//  Created by Faheem on 06/12/2021.
//

import UIKit
import SDWebImage

public class BaseTableViewCell : UITableViewCell {
    
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
    
    
}

