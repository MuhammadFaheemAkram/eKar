//
//  ViewMapViewController.swift
//  eKar
//
//  Created by Faheem on 14/03/2023.
//

import UIKit
import CoreLocation
import MapboxMaps

class ViewMapViewController: BaseViewController {
    
    //MARK: Properties
    private var viewMapBox: MapView!
    private var zoomLevel: CGFloat = 14
    var viewModel: ViewMapViewModel!

    //MARK: Outlets
    @IBOutlet weak var viewMapView: ViewMapView!
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        loadMap()
        addMarker()
    }
    

}
//MARK: - AnnotationInteractionDelegate Methods
extension ViewMapViewController: AnnotationInteractionDelegate {
    
    ///This method is called when user clicks on a marker
    public func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        openViewVehicleVC()
    }
    
}


//MARK: - Private Methods
private extension ViewMapViewController {
    
    func setNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.titleView = UIImageView(image: Image.navigationIcon)
    }
    
    ///Opens vehicle details view controller
    func openViewVehicleVC() {
        let vc = UIViewController.instantiate(ViewVehicleViewController.self, fromStoryboard: .Main)
        let viewModel = ViewVehicleViewModel(vehicleId: viewModel.vehicle.vehCode,
                                             repository: VehicleRepository())
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///load a new map with provided center from view model
    func loadMap() {
        
        let centerMap = CLLocationCoordinate2D(latitude: viewModel.vehicle.latitude,
                                                      longitude: viewModel.vehicle.longitude)
        let mapOptions = MapInitOptions(cameraOptions: CameraOptions(center: centerMap, zoom: zoomLevel))
        
        viewMapBox = MapView(frame: viewMapView.mapView.bounds, mapInitOptions: mapOptions)
        viewMapBox.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewMapView.mapView.addSubview(viewMapBox)
    }
    
    ///Add a new marker to the map
    func addMarker() {
        viewMapBox.mapboxMap.onNext(event: .mapLoaded) { [weak self] _ in
            guard let self = self else { return }
            
            let mapCoordinate = CLLocationCoordinate2D(latitude: self.viewModel.vehicle.latitude,
                                                       longitude: self.viewModel.vehicle.longitude)
            
            var marker = PointAnnotation(coordinate: mapCoordinate)
            marker.image = .init(image: Image.markerIcon!, name: "Apple Headquarter")
            
            // Create the `PointAnnotationManager` which will be responsible for handling this annotation
            let pointAnnotationManager = self.viewMapBox.annotations.makePointAnnotationManager()
            pointAnnotationManager.delegate = self
            // Add the annotation to the manager in order to render it on the map.
            pointAnnotationManager.annotations = [marker]
            
        }
    }
    
    
}

