//
//  ViewVehicleViewController.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class ViewVehicleViewController: BaseViewController {

    //MARK: Properties
    var viewModel: ViewVehicleViewModel!

    //MARK: Outlets
    @IBOutlet weak var viewVehicle: ViewVehicle!
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        setupBindings()
        registerNib()
        viewModel.getVehicleDeatils()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: kBlankString, style: .plain, target: nil, action: nil)
    }
    
    @IBAction
    func actionProceed(_ sender: UIButton){
        openOnBoardVehicleViewController()
    }

}

//MARK: Private Methods
private extension ViewVehicleViewController {
    
    func setNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.blueColor
        self.navigationItem.titleView = UIImageView(image: Image.navigationIcon)
    }
    
    func setBottomView() {
        let make = viewModel.vehicle?.attributes.make ?? ""
        let model = viewModel.vehicle?.attributes.model ?? ""
        viewVehicle.vehicleName.attributedText = Utils.getAttributedTextFor(make: make,
                                                                     model: model)
        viewVehicle.vehicleBrand.text = viewModel.vehicle?.attributes.style
    }
    
    func setBottomImage() {
        let firstImageUrl = viewModel.vehicleImage?.images.first?.link ?? ""
        self.setImageWithUrl(imageView: viewVehicle.vehicleImage, url: firstImageUrl)
    }
    
    func registerNib() {
        let vehicleImageNib = UINib(nibName: VehicleImageTableViewCell.reuseIdentifier, bundle: nil)
        viewVehicle.tableView.register(vehicleImageNib,
                           forCellReuseIdentifier: VehicleImageTableViewCell.reuseIdentifier)
        
        let vehicleInfoNib = UINib(nibName: VehichleDetailsTableViewCell.reuseIdentifier, bundle: nil)
        viewVehicle.tableView.register(vehicleInfoNib,
                           forCellReuseIdentifier: VehichleDetailsTableViewCell.reuseIdentifier)
        
        let aboutVehicleNib = UINib(nibName: VehicleMoreInfoTableViewCell.reuseIdentifier, bundle: nil)
        viewVehicle.tableView.register(aboutVehicleNib,
                           forCellReuseIdentifier: VehicleMoreInfoTableViewCell.reuseIdentifier)
        
        let keyFeatureNib = UINib(nibName: KeyFeatureTableViewCell.reuseIdentifier, bundle: nil)
        viewVehicle.tableView.register(keyFeatureNib,
                           forCellReuseIdentifier: KeyFeatureTableViewCell.reuseIdentifier)
    }
    
    private func openOnBoardVehicleViewController() {
        let vc = ViewOnBoardVehicleViewController.instantiate(ViewOnBoardVehicleViewController.self, fromStoryboard: .Main)
        let viewModel = ViewOnBoardViewModel()
        vc.viewModel = viewModel
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        self.present(navController, animated: true)
    }
}

//MARK: ViewModel Bindings
private extension ViewVehicleViewController {
    
    func setupBindings() {
        viewModel.isLoading.updateHandler = { [weak self] isLoading in
            self?.showLoader(isLoading)
        }
        
        viewModel.showAlert.updateHandler = { [weak self] alert in
            self?.showAlertView(message: alert.message, title: alert.title)
        }
        
        viewModel.reloadData.updateHandler = { [weak self] _ in
            self?.viewVehicle.tableView.reloadData()
            self?.setBottomImage()
        }
        
        viewModel.reloadBottomView.updateHandler = { [weak self] _ in
            self?.setBottomView()
        }
        
    }
}

//MARK: VehichleDetailsCellDelegate Methods
extension ViewVehicleViewController: VehichleDetailsCellDelegate {
    
    func didTapContractWorks() {
        showAlertVIew(message: LocalizedKey.howContractWorks.string, title: ALERT_APP_TITLE)
    }
    
}
