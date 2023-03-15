//
//  ViewOnBoardVehicleViewController.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class ViewOnBoardVehicleViewController: BaseViewController {
    
    
    //MARK: Properties
    var viewModel: ViewOnBoardViewModel!
    
    //MARK: Outlets
    @IBOutlet weak var viewOnBoardVehicleView: ViewOnBoardVehicleView!

    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        registerNib()
        setupBindings()
    }
    
    //MARK: Actions
    @IBAction
    func submitButtonAction(_ sender: UIButton) {
        viewModel.submitTapped()
    }
    
    @objc
    func didTapCloseButton(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
    //MARK: UITextField textChanged
    @IBAction
    func textChanged(_ sender: UITextField) {
        switch sender {
        case viewOnBoardVehicleView.commentTextField:
            viewModel.comments = sender.text ?? kBlankString
        default:
            break
        }
    }
    
    //MARK: ImagePickerController Methods
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        viewModel.updateSelectedImage(image: image)
        viewOnBoardVehicleView.collectionView.reloadData()
    }

}

//MARK: ViewModel Bindings
private extension ViewOnBoardVehicleViewController {
    
    ///Setup view model bindings
    func setupBindings() {
        viewModel.showAlert.updateHandler = { [weak self] alert in
            self?.showAlertView(message: alert.message, title: alert.title)
        }
        
    }
}
//MARK: Private Methods
private extension ViewOnBoardVehicleViewController {
    
    ///Set custom nav bar properties
    func setNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.blueColor
        self.navigationItem.titleView = UIImageView(image: Image.navigationIcon)
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "multiply"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(self.didTapCloseButton(_:)))
        self.navigationItem.leftBarButtonItem  = closeButton
    }
    
    ///Register Nib files
    func registerNib() {
        let nib = UINib(nibName: UploadVehicleImageCollectionViewCell.reuseIdentifier, bundle: nil)
        viewOnBoardVehicleView.collectionView.register(nib,
                                 forCellWithReuseIdentifier: UploadVehicleImageCollectionViewCell.reuseIdentifier)
        viewOnBoardVehicleView.collectionView.delegate = self
        viewOnBoardVehicleView.collectionView.dataSource = self
    }
    
    
}
