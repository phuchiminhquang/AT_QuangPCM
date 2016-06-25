//
//  CalculatorController.swift
//  Bai 7
//
//  Created by Quang Phu on 6/25/16.
//  Copyright © 2016 Quang Phu. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {

    
    
    var isLoad = false
    
    var currentText = ""
    var currentOperation = ""
    
    var result: Double = 0.0
    
    
    @IBOutlet weak var tfResult: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if !isLoad {
            let screenFrame = self.view.frame
            let customWidth: CGFloat = 200
            let customHeigth: CGFloat = 250
            
            let customFrame = CGRect(x: screenFrame.width / 2 - customWidth / 2, y: screenFrame.height / 2 - customWidth / 2, width: customWidth, height: customHeigth)
            
            let customCalculator = NSBundle.mainBundle().loadNibNamed("CustomCalculator", owner: nil, options: nil).last as! CustomCalculator
            customCalculator.frame = customFrame
            customCalculator.delegate = self
            self.view.addSubview(customCalculator)
            
            isLoad = true
        }
    }
}

extension CalculatorController: CustomCalculatorDelegate {
    func resetResult() {
        self.tfResult.text = ""
        currentText = ""
        currentOperation = ""
        result = 0.0
        self.tfResult.text = "0"
    }
    
    func sendCharacterWith(tag: Int) {
        switch tag {
        case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9:
            if currentText.characters.count < 16 {
                if currentText == "" && tag == 0 {
                    
                } else {
                    currentText += String(tag)
                    self.tfResult.text = currentText
                    print("number: \(tag)")
                    }
                }
        case 10, 11:
            if currentOperation == "" {
                result = Double(self.tfResult.text!)!
                currentOperation = tag == 10 ? "+" : "-"
                currentText = ""
            } else {
                result = (currentOperation == "+") ? result + Double(currentText)! : result - Double(currentText)!
                self.tfResult.text = String(Int(result))
                currentOperation = tag == 10 ? "+" : "-"
                currentText = ""
            }
        case 99:
            switch currentOperation {
            case "+":
                result += Double(currentText)!
                self.tfResult.text = String(Int(result))
            case "-":
                result -= Double(currentText)!
                self.tfResult.text = String(Int(result))
            default:
                print()
            }
            currentOperation = ""
            currentText = ""
        default:
            print("default")
        }
    }
}