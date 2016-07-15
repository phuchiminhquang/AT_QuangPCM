//
//  MapDetailVC.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Asiantech1 on 7/15/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit
import MapKit


class MapDetailVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locate: MKAnnotation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let location = CLLocationCoordinate2D(latitude: 16.0544068, longitude: 108.20216670000002)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 16.0544, longitude: 108.20)
        annotation.title = "Current Location"
        annotation.subtitle = "you're here"
        mapView.addAnnotation(annotation)
        
        annotation = MKPointAnnotation()
        let latitue = locate?.coordinate.latitude ?? 0
        let longtitue = locate?.coordinate.longitude ?? 0
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitue, longitude: longtitue)
        annotation.title = "ABC"
        annotation.subtitle = "XYZ"
        mapView.addAnnotation(annotation)
        
        showRouteOnMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = MyColor.borderRedColor
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func showRouteOnMap(){
        self.mapView.delegate = self
        let request = MKDirectionsRequest()
        let currentLocal = CLLocationCoordinate2D(latitude: 16.0762123, longitude: 108.2355277)
        
        let currentPlaceMark = MKPlacemark(coordinate: currentLocal, addressDictionary: nil)
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.title = "Current Location"
        if let location = currentPlaceMark.location {
            currentAnnotation.coordinate = location.coordinate
        }
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocal, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: locate!.coordinate, addressDictionary: nil))
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

