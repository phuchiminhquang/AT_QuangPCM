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

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let photos = ["bg_res1","bg_res2","bg_res3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        self.configurationUI()
        self.configPageController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func configurationUI() {

        //        self.navigationItem.rightBarButtonItem = barButton
        
        let button = UIButton(type: .Custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage(named: "bt_bg_favorite"), forState: .Normal)
        button.addTarget(self, action: .didTapFavorite, forControlEvents: .TouchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
    
    }
    
    func didTapFavoriteRightBarButton(sender: UIButton) {
        sender.setBackgroundImage(UIImage(named: "bt_bg_favorite_active"), forState: .Normal)
    }
    
    @IBAction func didTabNextSlide(sender: AnyObject) {
        if (self.pageControl.currentPage + 1 < photos.count) {
            self.pageControl.currentPage = self.pageControl.currentPage + 1
            let newOffset = CGPointMake(CGFloat(self.pageControl.currentPage * Int(collectionView.frame.size.width)), collectionView.contentOffset.y)
            self.collectionView.setContentOffset(newOffset, animated: true)
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
        self.pageControl.numberOfPages = photos.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.grayColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.currentPageIndicatorTintColor = MyColor.borderGrayColor
//        self.imageScrollView.addSubview(pageControl)
    }

    
    
}

extension RestaurantDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.photoImageView.image = UIImage(named: photos[indexPath.row])
        
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
        let reuseIdentifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = true
        } else {
            pinView!.annotation = annotation
        }
        pinView!.image = UIImage(named: "pin")
        // let button = UIButton(type: UIButtonType.DetailDisclosure) as UIButton
        // pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    
//    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
//        let detailMap = DetailMapViewController()
//        self.navigationController?.pushViewController(detailMap, animated: true)
//        let selectedLocal = view.annotation! as MKAnnotation
//        detailMap.place = selectedLocal
//    }
    
    // map zom
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 16.0718911, longitude: 108.2228753)
        let span = MKCoordinateSpanMake(0.05, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}

