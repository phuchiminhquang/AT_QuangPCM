//
//  MapDetailVC.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Asiantech1 on 7/15/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit
import MapKit


let currentLocal = CLLocationCoordinate2D(latitude: 16.0544, longitude: 108.20)
var resLocal = CLLocationCoordinate2D(latitude: 0, longitude: 0 )

class MapDetailVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locate: MKAnnotation? = nil
    var resLocation: Location!
    var centerLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.loadLocation()
        showRouteOnMap(currentLocal,resLocal: resLocal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLocation() {
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = currentLocal
        annotation.title = "Current Location"
        annotation.subtitle = "you're here"
        mapView.addAnnotation(annotation)
        
        annotation = MKPointAnnotation()
        let latitue = self.resLocation.latitue
        let longtitue = self.resLocation.longtitue
        resLocal = CLLocationCoordinate2D(latitude: latitue, longitude: longtitue)
        annotation.coordinate = resLocal
        annotation.title = self.resLocation.name
        annotation.subtitle = self.resLocation.address
        mapView.addAnnotation(annotation)

    }
}


extension MapDetailVC: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = MyColor.borderRedColor
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func showRouteOnMap(currentLocal: CLLocationCoordinate2D, resLocal: CLLocationCoordinate2D){
        self.mapView.delegate = self
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocal, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: resLocal, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Automobile
        let direction = MKDirections(request: request)
        direction.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            if (unwrappedResponse.routes.count > 0) {
                self.mapView.addOverlay(unwrappedResponse.routes[0].polyline)
                self.mapView.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
    }
}

extension MapDetailVC: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)

    }
    
}

