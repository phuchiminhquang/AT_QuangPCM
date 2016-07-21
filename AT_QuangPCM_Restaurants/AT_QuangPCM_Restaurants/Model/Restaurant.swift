//
//  Restaurant.swift
//  AT_QuangPCM_Restaurants
//
//  Created by Quang Phu on 7/14/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import Foundation
import UIKit



//https://api.foursquare.com/v2/venues/4d4361d01928a35daba1ad70


//&client_id=UCDOMOO2J2MXZ1RHLOKRN4YEEYRY4P55MJSZVISVSXO3TTKH&client_secret=5Y5EPMYFHV3RZQLGQSPRS4F25CM5NYY2ERORJ0A50SMGCBY2&v=20160721&

let photoPrefixURL = "https://api.foursquare.com/v2/venues/"
let photoSuffixURL = "/photos?client_id=UCDOMOO2J2MXZ1RHLOKRN4YEEYRY4P55MJSZVISVSXO3TTKH&v=20160720&client_secret=5Y5EPMYFHV3RZQLGQSPRS4F25CM5NYY2ERORJ0A50SMGCBY2&v=20160721"

extension Strings {
    static let imageSizeOrigin = "original"
    static let imageSizeCustom = "300x300"
}

//class Food {
//    var name = ""
//    var description = ""
//    var photo: [String]?
//    
//    init(name: String?, des: String?, photo: [String]?) {
//        self.name = name ?? ""
//        self.description = des ?? ""
//        self.photo = photo ?? []
//    }
//}


class Location {
    var name = ""
    var address = ""
    var latitue: Double = 0.0
    var longtitue: Double = 0.0
}

class Restaurant {
    
    var id = ""
    var name = ""
    var location: Location?
    var photoPathURL = ""
    var photoLinks: [String] = []
    var thumbnailImage: UIImage!
    
    var rating = 0
    var isFavoratie = false
    
    init(id: String, name: String,pathURL: String, location: Location?) {
        self.id = id
        self.name = name
        self.photoPathURL = pathURL
        self.location = location
    }
    
    static func getObjectFromJson(venueJson: NSDictionary) -> Restaurant {
        var restaurant: Restaurant?
        let location = Location()
        
        // Get venue
        let idVenue = venueJson["id"] as? String ?? ""
        let nameVenue = venueJson["name"] as? String ?? ""
        let photoURL = photoPrefixURL + idVenue + photoSuffixURL
        if let locationJson = venueJson["location"] as? NSDictionary {
            location.name = nameVenue
            location.address = locationJson["address"] as? String ?? ""
            location.latitue = locationJson["lat"] as? Double ?? 0
            location.longtitue = locationJson["lng"] as? Double ?? 0
        }
        restaurant = Restaurant(id: idVenue, name: nameVenue,pathURL: photoURL, location: location)

        return restaurant!
    }
    
    static func getPhotosStringFromJson(json: NSDictionary) -> [String] {
        var photosString: [String] = []
        if let items = json.objectForKey("items") as? NSArray {
            for item in items {
                let prefix = item.objectForKey("prefix") as? String ?? ""
                let suffix = item.objectForKey("suffix") as? String ?? ""
                
                let photoString = prefix + Strings.imageSizeOrigin + suffix
                print(photoString)
                photosString.append(photoString)
            }
        }
        print(photosString.count)
        return photosString
    }

}

class Venues: NSObject {
    
    var restaurants = [Restaurant]()
    
    class var sharedInstance: Venues {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Venues? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Venues()
        }
        return Static.instance!
    }
    
    func addRestaurant(res: Restaurant) {
        Venues.sharedInstance.restaurants.append(res)
        print("COUNT: \(Venues.sharedInstance.restaurants.count)")
        
    }
}

