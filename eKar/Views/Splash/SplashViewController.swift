//
//  SplashViewController.swift
//  eKar
//
//  Created by Faheem on 14/03/2023.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var splashView: SplashView!
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        GCD.async(.Main, delay: 1.5) { [unowned self] in
            self.openViewMapVC()
        }
    }

}

//MARK: Private Extension
private extension SplashViewController {
    
    func setView(){
        splashView.spalshImage.image = Image.splashImage
    }
    
    /// This function is response to open map view controller
    func openViewMapVC() {
        let vc = UIViewController.instantiate(ViewMapViewController.self, fromStoryboard: .Main)
        let vehicle = VehicleModel(vehCode: "JTDZN3EU0E3298500", latitude: 37.785834, longitude: -122.406417)
        vc.viewModel = ViewMapViewModel(vehicle: vehicle)
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}
