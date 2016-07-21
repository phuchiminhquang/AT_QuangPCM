//
//  RootController.swift
//  loadphoto
//
//  Created by Asiantech1 on 7/20/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    var refreshCtrl: UIRefreshControl!
    var refreshControl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: NSURLSessionDownloadTask!
    var session: NSURLSession!
    var cache:NSCache!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = NSURLSession.sharedSession()
        task = NSURLSessionDownloadTask()
        
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(RootController.refreshTableView), forControlEvents: .ValueChanged)
        self.refreshControl = self.refreshCtrl
        
        self.tableData = []
        self.cache = NSCache()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTableView(){
        
        let url:NSURL! = NSURL(string: "https://itunes.apple.com/search?term=flappy&entity=software")
        task = session.downloadTaskWithURL(url, completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if location != nil{
                let data:NSData! = NSData(contentsOfURL:location!)
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves)
                    self.tableData = dic.valueForKey("results") as! [AnyObject]
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        task.resume()
    }
    
}

extension RootController: UITableViewDataSource, UITableViewDelegate {
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 1
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath)
        let dictionary = self.tableData[indexPath.row] as! [String:AnyObject]
        cell.textLabel!.text = dictionary["trackName"] as? String
        cell.imageView?.image = UIImage(named: "placeholder")
        
        if (self.cache.objectForKey(indexPath.row) != nil){
            // 2
            cell.imageView?.image = self.cache.objectForKey(indexPath.row) as? UIImage
        }else{
            // 3
            let artworkUrl = dictionary["artworkUrl100"] as! String
            let url:NSURL! = NSURL(string: artworkUrl)
            task = session.downloadTaskWithURL(url, completionHandler: { (location, response, error) -> Void in
                if let data = NSData(contentsOfURL: url){
                    // 4
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        // 5
                        if let updateCell = tableView.cellForRowAtIndexPath(indexPath) {
                            let img:UIImage! = UIImage(data: data)
                            updateCell.imageView?.image = img
                            self.cache.setObject(img, forKey: indexPath.row)
                        }
                    })
                }
            })
            task.resume()
        }
        return cell
    }
}
