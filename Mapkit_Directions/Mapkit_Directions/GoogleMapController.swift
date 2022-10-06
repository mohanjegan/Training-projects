//
//  GoogleMapController.swift
//  Mapkit_Directions
//
//  Created by Mohan on 06/10/22.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class GoogleMapController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sourceLat = 11.020509
        let sourceLong = 76.954535
        let destinationLat = 13.083981
        let destinationLong = 80.274854
        
        let sourceLocation = "\(sourceLat),\(sourceLong)"
        let destinationLocation = "\(destinationLat),\(destinationLong)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&mode=driving&key=AIzaSyAHo6mSb34zrvv3WtLzEicELEbgFlsTZko"
        
        AF.request(url).responseJSON { (reseponse) in
            guard let data = reseponse.data else {
                return
            }
            
            do {
                let jsonData = try JSON(data: data)
                let routes = jsonData["routes"].arrayValue
                
                for route in routes {
                    let overview_polyline = route["overview_polyline"].dictionary
                    let points = overview_polyline?["points"]?.string
                    let path = GMSPath.init(fromEncodedPath: points ?? "")
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeColor = .systemBlue
                    polyline.strokeWidth = 5
                    polyline.map = self.mapView
                }
            }
             catch let error {
                print(error.localizedDescription)
            }
        }
      let sourceMarker = GMSMarker()
        sourceMarker.position = CLLocationCoordinate2D(latitude: sourceLat, longitude: sourceLong)
        sourceMarker.title = "Coimbatore"
        sourceMarker.snippet = "Manchester of TamilNadu"
        sourceMarker.map = self.mapView

        let destinationMarker = GMSMarker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLong)
        destinationMarker.title = "Chennai"
        destinationMarker.snippet = "Capital of TamilNadu"
        destinationMarker.map = self.mapView
        
        let camera = GMSCameraPosition(target: sourceMarker.position, zoom: 10)
        mapView.animate(to: camera)
    }
}
