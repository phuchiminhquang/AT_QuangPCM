//
//  MapVC.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
//        
        
       
        
        let resFirst = Venues.sharedInstance.restaurants[0]
        
        let location = CLLocationCoordinate2D(latitude: resFirst.location!.latitue, longitude: resFirst.location!.longtitue)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)

         self.loadAllLocation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func loadAllLocation() {
        if Venues.sharedInstance.restaurants.count > 0 {
            for res in Venues.sharedInstance.restaurants {
                let location = res.location
                let annoation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: location?.latitue ?? 0, longitude: location?.longtitue ?? 0)
                annoation.coordinate = coordinate
                annoation.title = location?.name
                annoation.subtitle = location?.address
                self.mapView.addAnnotation(annoation)
            }
        }
    }
}



extension MapVC: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = MyColor.borderRedColor
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKindOfClass(MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            
            annotationView = av
            let iconView = UIImageView(image: UIImage(named: "ic_tbItem_favorite"))
            annotationView?.leftCalloutAccessoryView = iconView
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "bg_pin")
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
        }
        
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

