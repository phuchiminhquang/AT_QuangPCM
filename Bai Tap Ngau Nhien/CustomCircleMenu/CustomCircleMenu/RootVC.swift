//
//  RootVC.swift
//  CustomCircleMenu
//
//  Created by Quang Phu on 7/7/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class RootVC: UIViewController {
    
    let dataSrouce: [(title: String, imageName: String)] = [("Name 1", "but1"),
                                                            ("Name 2", "but2"),
                                                            ("Name 3", "but3"),
                                                            ("Name 4", "but4"),
                                                            ("Name 5", "but5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonShowView(sender: UIButton) {
        let circleMenuView = MyCircleMenu(frame: self.view.bounds, radius: 120)
        self.view.addSubview(circleMenuView)
        circleMenuView.delegate = self
    }
}

extension RootVC: MyCircleMenuDelegate {
    
    func numberOfItem(circleView: MyCircleMenu) -> Int! {
        return self.dataSrouce.count
    }
    
    func titleAtIndex(circleView: MyCircleMenu, index: Int) -> String! {
        return self.dataSrouce[index].title
    }
    
    func imageNameAtIndex(circleView: MyCircleMenu, index: Int) -> String! {
        return self.dataSrouce[index].imageName
    }
}


//class RootVC: UIViewController {
//
//    // MARK: IBOutlet & IBAction
//    @IBAction func buttonShowView(sender: AnyObject) {
//        self.circleMenu = MyCircleMenu(frame: self.view.bounds, r: 100)
//        
//        self.view.addSubview(self.circleMenu!)
//        
//        self.circleMenu.delegate = self
//    }
//    
//    // MARK: Property
//    var numberItems = 5
//    var blurView = UIView()
//    var cancelButton = UIButton()
//    
//    var subMenus: [SubMenuView] = []
//    var photos = ["but2.png","but1.png","but3.png","but4.png","but5.png"]
//    var nameSubMenu = ["Edit","Home","Detail","Friend","Family"]
//    
//    var datasource: [(photo: String,name: String)] = [("but1","Home"),
//                                         ("but2","Edit"),
//                                         ("but3","Friend"),
//                                         ("but4","Profile"),
//                                         ("but5","Detail")]
//    
//    var circleMenu: MyCircleMenu!
//    
//    // MARK: Init View
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
//}
//
//extension RootVC: MyCircleMenuDelegate {
//    func getPhotoFotItemAtIndex(view: MyCircleMenu, index: Int) -> String! {
//        return self.datasource[index].photo
//    }
//    
//    func getNameForItemAtIndex(view: MyCircleMenu, index: Int) -> String! {
//        return self.datasource[index].name
//    }
//}
