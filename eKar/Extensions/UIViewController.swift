//
//  UIViewController.swift
//  Point City
//
//  Created by Faheem on 07/11/2020.
//  Copyright © 2020 Crymzee Networks. All rights reserved.
//

import UIKit

extension UIViewController {
    static var storyboardId: String {
            return String(describing: self)
    }
    static func instantiate<ViewController: UIViewController>(_ viewControllerType: ViewController.Type, fromStoryboard storyboardName: UIStoryboard.Name) -> ViewController {
            let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: viewControllerType.storyboardId) as! ViewController
    }
    
}
