//
//  HomeViewController.swift
//  CustomCircleMenu
//
//  Created by Quang Phu on 7/8/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

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
        self.view.backgroundColor = UIColor.yellowColor()
        let circleMenuView = CircleMenuView(frame: self.view.bounds, radius: 120)
        self.view.addSubview(circleMenuView)
        circleMenuView.delegate = self
    }
}

extension HomeViewController: CircleMenuViewDelegate {
    
    func numberOfItem(circleView: CircleMenuView) -> Int! {
        return self.dataSrouce.count
    }
    
    func titleAtIndex(circleView: CircleMenuView, index: Int) -> String! {
        return self.dataSrouce[index].title
    }
    
    func imageNameAtIndex(circleView: CircleMenuView, index: Int) -> String! {
        return self.dataSrouce[index].imageName
    }
}
