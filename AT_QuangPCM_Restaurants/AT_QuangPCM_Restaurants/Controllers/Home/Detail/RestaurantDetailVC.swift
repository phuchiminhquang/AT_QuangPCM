//
//  RestaurantDetailVC.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Quang Phu on 7/14/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit
import MapKit


private extension Selector {
    static let didTapFavorite = #selector(RestaurantDetailVC.didTapFavoriteRightBarButton(_:))
}

struct LocationCoordinate {
    static let DaNang = CLLocation(latitude: 16.0544068, longitude: 108.20216670000002)
}

class RestaurantDetailVC: UIViewController {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantShortDescription: UILabel!
    @IBOutlet weak var restaurantLongDescription: UILabel!
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: Property
    let photos = ["bg_res1","bg_res2","bg_res3"]
    var restautant: Restaurant?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
//        centerMapOnLocation(LocationCoordinate.DaNang)
        self.configurationUI()
        self.fillData()
        self.configPageController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func setupData(restaurant: Restaurant) {
        self.restautant = restaurant
    }
    
    func configurationUI() {
        
        let button = UIButton(type: .Custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage(named: "bt_bg_favorite"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "bt_bg_favorite_active"), forState: .Selected)
        button.addTarget(self, action: .didTapFavorite, forControlEvents: .TouchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        
        self.loadLocation()
        
        // show artwork on map
//        let artwork = Artwork(title: "King David Kalakaua",
//                              locationName: "Waikiki Gateway Park",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: 16.0538, longitude: 108.2772))
//        mapView.delegate = self
//        mapView.addAnnotation(artwork)
        
    }
    
    func loadLocation() {
        let longtitude = self.restautant?.location?.longtitue ?? 0
        let latitude = self.restautant?.location?.latitue ?? 0
        let title = self.restautant?.name ?? "No Name"
        let subTitle = self.restautant?.location?.address ?? "No Address"

        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subTitle
        mapView.addAnnotation(annotation)
    }
    
    func fillData() {
        if let restaurant = self.restautant {
            self.restaurantName.text = restaurant.name
            self.restaurantAddress.text = restaurant.location?.address
            self.restaurantShortDescription.text = restaurant.name
            self.restaurantLongDescription.text = restaurant.name
        }
    }
    
    func didTapFavoriteRightBarButton(sender: UIButton) {
        sender.selected = !sender.selected

    }
    
    @IBAction func didTabNextSlide(sender: AnyObject) {
        let count = self.restautant?.photoLinks.count

        if (self.pageControl.currentPage + 1 < count) {
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage * Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            collectionView.setContentOffset(newOffset, animated: true)
        } else {
            self.pageControl.currentPage = 0
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage * Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            collectionView.setContentOffset(newOffset, animated: true)
        }
    }
    

    @IBAction func didTabPreviousSlide(sender: AnyObject) {
        if (self.pageControl.currentPage - 1 >= 0) {
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage * Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            collectionView.setContentOffset(newOffset, animated: true)
        }
    }
    
    func configPageController() {
        if let count = self.restautant?.photoLinks.count where count < 5{
            self.pageControl.numberOfPages = count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.blueColor()
            self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
            self.pageControl.currentPageIndicatorTintColor = MyColor.borderGrayColor
        } else {
            self.pageControl.hidden = true
        }
    }
    
    // Config for MapKit
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension RestaurantDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.restautant?.photoLinks.count {
            return count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        let photoPath = self.restautant!.photoLinks[indexPath.row]
  
        self.downloadPhoto(photoPath, index: indexPath.row)
        
//        if Cache.sharedInstance.objectForKey(photoPath) != nil {
//            cell.photoImageView.image = Cache.sharedInstance.objectForKey(photoPath) as? UIImage
//        } else {
//            cell.photoImageView.image = nil
//            self.downloadPhoto(photoPath, index: indexPath.row)
//        }
        
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.collectionView.frame.width
        let height = self.collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func downloadPhoto(photoPath: String, index: Int) {
        print("DOWNLOAD IMAGE \(photoPath)")
    
        let request = Request.getRequestWith("GET", strURL: photoPath, parameters: nil)
        API.sharedInstance.dowloadImage(photoPath, request: request) { (image, error) in
            if error {
                print("ERROR DURING DOWNLOAD IMAGE \(photoPath)")
            } else {
                let indexPath = NSIndexPath(forItem: index, inSection: 0)
                if let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? CustomCollectionViewCell {
                    cell.photoImageView.image = image
                }
            }

            }
    }
}




extension RestaurantDetailVC: MKMapViewDelegate {
    
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
            let detailMap = MapDetailVC()
            detailMap.resLocation = restautant?.location
            self.navigationController?.pushViewController(detailMap, animated: true)
        }
        
    }
    
    
    // map zom
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}

