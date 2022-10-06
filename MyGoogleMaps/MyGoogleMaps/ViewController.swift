//
//  ViewController.swift
//  MyGoogleMaps
//
//  Created by Mohan on 30/09/22.
//
import CoreLocation
import UIKit
import GoogleMaps
import  GooglePlaces
//import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate, UISearchResultsUpdating {
//    let mapView = MKMapView()
    let manager = CLLocationManager()
    let searchVc = UISearchController(searchResultsController: ResultViewController())
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Maps"
//        view.addSubview(mapView)
        searchVc.searchResultsUpdater = self
        navigationItem.searchController = searchVc
        
        
                manager.delegate  = self
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
        
                GMSServices.provideAPIKey("AIzaSyDSw6JYvXRtYM5fntUFidVoFEKqC1lmH7E")
        
        
        //  print("license: \(GMSServices.openSourceLicenseInfo())")
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        mapView.frame = view.bounds
//    }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else{
                return
            }
            let coordinate = location.coordinate
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
                    let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
                    view.addSubview(mapView)
                    let marker = GMSMarker()
                    marker.position = coordinate
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
                guard let Place = placemarks?.first, error == nil else{
                    return
                }
                    marker.title = Place.locality
                    marker.snippet = Place.administrativeArea
                    marker.map = mapView
            }
        }
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultsVc = searchController.searchResultsController as? ResultViewController
        else{
            return
        }
        
//        resultsVc.delegate = self
//
//        GooglePlacesManager.shared.findPlaces(query: query) { result in
//            switch result{
//            case .success(let places):
//
//                DispatchQueue.main.async {
//                    resultsVc.update(with: places)
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

//extension ViewController: ResultViewControllerDelegate{
//    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
//        //Remove all pins
//
//        //Add new pin
//        let pin = MKPointAnnotation()
//        pin.coordinate  = coordinates
//        mapView.addAnnotation(pin)
//        mapView.setRegion(
//            MKCoordinateRegion(
//                center: coordinates,
//                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)),
//            animated: true)
//
//    }
//
//
//}
