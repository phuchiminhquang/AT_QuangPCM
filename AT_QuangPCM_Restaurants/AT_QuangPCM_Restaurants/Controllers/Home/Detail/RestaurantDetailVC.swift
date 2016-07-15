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
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    var restautant: Restaurant? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        centerMapOnLocation(initialLocation)
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
    
        
        
        
        // show artwork on map
//        let artwork = Artwork(title: "King David Kalakaua",
//                              locationName: "Waikiki Gateway Park",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: 16.0538, longitude: 108.2772))
//        mapView.delegate = self
//        mapView.addAnnotation(artwork)
        
        let location = CLLocationCoordinate2D(latitude: 16.0544068, longitude: 108.20216670000002)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)

        let longtitude = self.restautant?.longtitue ?? 0
        let latitude = self.restautant?.latitue ?? 0
        let title = self.restautant?.name ?? "No Name"
        let subTitle = self.restautant?.address ?? "No Address"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        annotation.title = title
        annotation.subtitle = subTitle
        mapView.addAnnotation(annotation)
    
    }
    
    
    func fillData() {
        if let restaurant = self.restautant {
            self.restaurantName.text = restaurant.name
            self.restaurantAddress.text = restaurant.address
            self.restaurantShortDescription.text = restaurant.shortDes
            self.restaurantLongDescription.text = restaurant.longDes
        }
    }
    
    func didTapFavoriteRightBarButton(sender: UIButton) {
        sender.selected = !sender.selected
//        sender.setBackgroundImage(UIImage(named: "bt_bg_favorite_active"), forState: .Normal)
    }
    
    @IBAction func didTabNextSlide(sender: AnyObject) {
        var count = 0
        if let foods = self.restautant?.food {
            count = foods[0].photo?.count ?? 0
        }

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
        if let foods = self.restautant?.food {
            self.pageControl.numberOfPages = foods[0].photo?.count ?? 0
        }

        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.grayColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.currentPageIndicatorTintColor = MyColor.borderGrayColor
//        self.imageScrollView.addSubview(pageControl)
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
        if let foods = self.restautant?.food {
            return foods.count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let foods = self.restautant?.food {
            let count = foods[section].photo?.count ?? 0
            print("\(count)")
            return count
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        let foodPhotoOfSectionAtIndex = self.restautant?.food?[indexPath.section].photo?[indexPath.row] ?? "no_picture"
        print("\(foodPhotoOfSectionAtIndex)")
        cell.photoImageView.image = UIImage(named: foodPhotoOfSectionAtIndex)
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = self.collectionView.frame.width
        let height = self.collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}



extension RestaurantDetailVC: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if let annotation = annotation as? Artwork {
//            let identifier = "pin"
//            var view: MKPinAnnotationView
//            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
//                as? MKPinAnnotationView { // 2
//                dequeuedView.annotation = annotation
//                view = dequeuedView
//            } else {
//                // 3
//                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                view.canShowCallout = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//            }
//            return view
//        }
//        return nil
//        let reuseIdentifier = "red_pin"
//        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
//        if pinView == nil {
//            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            pinView!.canShowCallout = true
//        } else {
//            pinView!.annotation = annotation
//        }
//        pinView!.image = UIImage(named: "red_pin")
//        let button = UIButton(type: UIButtonType.DetailDisclosure) as UIButton
//        pinView?.rightCalloutAccessoryView = button
//        return pinView
        
        let identifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            pinView?.tintColor = UIColor.greenColor()
            
//            pinView?.image = UIImage(named: "ic_tbItem_map")
            let button = UIButton(type: UIButtonType.DetailDisclosure) as UIButton
            pinView?.rightCalloutAccessoryView = button
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let detailMap = MapDetailVC()
        let selectedLocal = view.annotation! as MKAnnotation
        detailMap.locate = selectedLocal
        self.navigationController?.pushViewController(detailMap, animated: true)
    }

    
    
    // map zom
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}

