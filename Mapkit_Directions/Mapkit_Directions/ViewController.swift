//
//  ViewController.swift
//  Mapkit_Directions
//
//  Created by Mohan on 06/10/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let sourceLocation = CLLocationCoordinate2D(latitude: 11.020509,
                                                    longitude: 76.954535)
        let destinationLocation = CLLocationCoordinate2D(latitude: 13.083981
                                                         , longitude: 80.274854)
        createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
        self.mapView.delegate = self
    }
    @IBAction func btnGoogle(_ sender: Any) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "GoogleMapControllerID")
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createPath(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D){
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation,
                                          addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation,
                                          addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Coimbatore"
        sourceAnnotation.subtitle = "Manchester of TamilNadu"
        if let location = sourcePlaceMark.location{
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Chennai"
        destinationAnnotation.subtitle = "Capital of TamilNadu"
        if let location = destinationPlaceMark.location{
            destinationAnnotation.coordinate = location.coordinate
        }
        self.mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .any
        
        
        let direction = MKDirections(request: directionRequest)
        direction.calculate { (response, error) in
            guard let response = response else{
                if let error = error{
                    print("Error Found \(error.localizedDescription)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }

}

extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .systemBlue
        return renderer
    }
}
