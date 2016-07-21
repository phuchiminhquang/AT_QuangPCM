//
//  RootVC.swift
//  DemoLoadMore
//
//  Created by Asiantech1 on 7/21/16.
//  Copyright © 2016 Asiantech1. All rights reserved.
//

import UIKit

class RootVC: UIViewController {

    private var items = [Cell]()
    private var limit = 50
    private var page = 1

    private var isLoading = false
    private var isSentRequest = true
    private var searchKey = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configUI() {
        //Register nib
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        self.indicator.hidesWhenStopped = true
        self.indicator.stopAnimating()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func loadData() {
        self.indicator.startAnimating()
        let parameters = ["key" : self.searchKey,
                          "page" : self.page,
                          "limit": self.limit]
        let request = Request.getRequestWith("GET", strURL: nil, parameters: parameters)
        API.sharedInstance.connect(request) { (items, error, message) in
            self.indicator.stopAnimating()
            if !error {
                dispatch_async(dispatch_get_main_queue()) {
                    if items!.count < self.limit {
                        self.isSentRequest = false
                        print("WERSERVIE OUT OF DATA")
                    }
                    
                    let beginIndex = self.items.count
                    let lastIndex = self.items.count + (items?.count ?? 0)
                    
                    var indexPaths = [NSIndexPath]()
                    for index in beginIndex..<lastIndex{
                        indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
                    }
                    self.items += items ?? []
                    
                    //Update tableView
                    self.tableView.beginUpdates()
                    self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Right)
                    self.tableView.endUpdates()
                    
                    self.isLoading = false
                    print("Loaded data isLoading: \(self.isLoading)")
                }
            }
        }
    }
    
    func refresh() {
        self.items = []
        self.page = 1
        self.tableView.reloadData()
        self.view.endEditing(true)
    }
    
    func refreshSearchBar(searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = ""
    }
}



extension RootVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? TableViewCell
        
        let item = items[indexPath.row]
        cell?.name.text = String(indexPath.row)
        cell?.des.text = item.description
        cell?.photo.image = UIImage(named: "place_holder")
        cell?.photo.dowloadImageFrom(item.photoURL, contentMode: .ScaleAspectFit)
        return cell!
    }
}

extension RootVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchKey = searchBar.text ?? ""
//        guard newKey != "" else {
//            return
//        }
//        if newKey != self.searchKey {
            self.refreshSearchBar(searchBar)
            self.refresh()
            self.loadData()
//        }
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.refreshSearchBar(searchBar)
    }
}

extension RootVC: UIScrollViewDelegate {
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Load More
        if scrollView.contentOffset.y + self.view.bounds.size.height - scrollView.contentSize.height > 150 {
            if !isLoading && isSentRequest && self.searchKey != "" {
                self.isLoading = true
                self.page += 1
                self.loadData()
                print("LOADING DATA isLoading \(self.isLoading)")
            }
        } else if scrollView.contentOffset.y < -200 {
            self.refresh()
            self.loadData()
        }
    }
}
