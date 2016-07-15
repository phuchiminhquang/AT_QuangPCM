//
//  Artwork.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Asiantech1 on 7/15/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
