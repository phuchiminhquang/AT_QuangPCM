//
//  HomeVC.swift
//  AT-QuangPCM
//
//  Created by Quang Phu on 7/13/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

extension Strings {
    
    static let prefixURL = "https://api.foursquare.com/v2/venues/explore?ll=16.070531,108.224599&client_id=BPQMVDAIHO45WWSBEHTSCEZP45JT2GPKGKTPITJEFBDJRINC&client_secret=3LWA1WMRDH53ZJUTTEGO4MJUVLKNHH4KUMZFB3SQSOXYBZ0F&v=20160721&"
    
//    static let APIToken = "0GBOD4RRLKAIBGM1HU0H2GSKIGUP0TEC5JWD45DOH24EQZOR&v=20160721"
//    static let suffixURL = "&v=20160718&ll=16.070531,108.224599&"
}

class HomeVC: UIViewController {

    
    let pathURL = "https://api.foursquare.com/v2/venues/explore?oauth_token=AC23AZTMHHF1RQY4BOT0CSUNIWAXJGROF4I4HNKBMOXSCFEW&v=20160718&v=20160718&ll=16.070531,108.224599&limit=10&offset=0"

    
    @IBOutlet private weak var restaurantTableView: UITableView!
    
    // MARK: private
    private var datasource: NSDictionary?
    private var restaurantNames = [String]()
    private var restaurants:[Restaurant] = []
    
    private var offset = 0
    private var limit = 10
    private var isLoading = true // false when retrived data from API
    private var isSentRequest = true // enable user to sent request
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.datasource = nil
        self.loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    // MARK: private function
    func loadData() {
        
        let parameters = ["offset": offset, "limit":limit]
        
        let request = Request.getRequestWith("GET", strURL: nil, parameters: parameters)
        API.sharedInstance.connect(request) { (data, error, message) in
            if error {
                print("ERROR JSON: \(message)")
            } else {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        //print(json)
                        if let response = json["response"] {
                            if let venues = response["venues"] as? NSArray {
                                
                                if venues.count < self.limit {
                                    self.isSentRequest = false
                                    print("WERSERVIE OUT OF DATA")
                                }
                                
                                for (index, item) in venues.enumerate() {
                                    let res = Restaurant.getObjectFromJson(item as! NSDictionary)
                                    Venues.sharedInstance.addRestaurant(res)
                                    //                                            self.restaurants.append(res)
                                    self.getListPhotos(res, index: index + self.offset)
                                }
                                self.offset = Venues.sharedInstance.restaurants.count
                                self.isLoading = false
                                print("Loaded data isLoading: \(self.isLoading)")

                            }
                        }

                    }
                } catch {
                    
                }
            }
        }
        
        // Register xib flie for TableViewCell
        let nib = UINib(nibName: Strings.restaurantCellIdentified, bundle: nil)
        self.restaurantTableView.registerNib(nib, forCellReuseIdentifier: Strings.restaurantCellIdentified)
    }
    
    func getListPhotos(res: Restaurant, index: Int) {
        let photoPathURL = res.photoPathURL
        let request = Request.getRequestWith("GET", strURL: photoPathURL, parameters: nil)
        
        API.sharedInstance.connect(request) { (data, error, message) in
            if !error {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        if let response = json.objectForKey("response") as? NSDictionary {
                            if let photos = response.objectForKey("photos") as? NSDictionary {
                                
                                let photosString = Restaurant.getPhotosStringFromJson(photos)
                                res.photoLinks = photosString
                                
                                if res.photoLinks.count > 0 {
                                    print("RESphotolink \(res.photoLinks[0])")
                                    self.downloadImage(res.photoLinks[0], index: index)
                                }
                            }
                        }
                    }
                } catch {
                }
            }
            print("DONE GET PHOTOS OF VENUE \(res.name)")
        }
        self.restaurantTableView.reloadData()
    }
    
    func downloadImage(strURL: String, index: Int = -1) {
        print("download Image: \(strURL)")
        let request = Request.getRequestWith("GET", strURL: strURL, parameters: nil)
        API.sharedInstance.connect(request) { (data, error, message) in
            if !error {
//                let item = self.restaurants[index]
                let item = Venues.sharedInstance.restaurants[index]
                item.thumbnailImage = UIImage(data: data!)
                UIImage()
                
                print("Da Load Image for \(item.name)")
                var indexPaths = [NSIndexPath]()
                indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
                self.restaurantTableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }

}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Venues.sharedInstance.restaurants.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Strings.restaurantCellIdentified, forIndexPath: indexPath) as? RestaurantCell
        
        let res = Venues.sharedInstance.restaurants[indexPath.row]
        
        cell?.name.text = res.name
        
        if (res.thumbnailImage != nil) {
            cell?.photo.image = res.thumbnailImage
        } else {
            cell?.photo.image = nil
        }
        
        cell?.accessoryType = .DisclosureIndicator
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = RestaurantDetailVC(nibName: "RestaurantDetailVC", bundle: nil)
        let restaurant = Venues.sharedInstance.restaurants[indexPath.row]
        detail.setupData(restaurant)
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}

extension HomeVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("---------------------------------------")
        print(scrollView.contentOffset)
        print(scrollView.contentSize)
        print(self.view.bounds.size)
        if scrollView.contentOffset.y + self.view.bounds.size.height - scrollView.contentSize.height > 50 {
            if !isLoading && isSentRequest {
                
                self.isLoading = true
                print("LOADING DATA isLoading \(self.isLoading)")
                
                self.loadData()
            }
            print("\(scrollView.contentOffset.y + self.view.bounds.size.height - scrollView.contentSize.height) Stay at the last row")
        }
    }
}



















