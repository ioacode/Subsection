//
//  SingleItemController.swift
//  Yups
//
//  Created by balcomm on 06/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import Foundation
import UIKit

class SingleItemController: UIViewController {
    @IBOutlet weak var labelCanselected: UILabel!
    @IBOutlet weak var labelValueSelected: UILabel!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    
    var valueTotalSelected: Int = 0
    var valueTotalSelectedUpdate: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelCanselected.text = "You can Selected \(valueTotalSelected) Items"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func pressMinus(_ sender: Any) {
        if valueTotalSelectedUpdate > 0 {
            valueTotalSelectedUpdate -= 1
        }else if valueTotalSelectedUpdate  ==  0{
             alertShow(title: "", message: "Please selected item", controller: self)
        }
        labelValueSelected.text = "\(valueTotalSelectedUpdate)"
    }
    
    @IBAction func pressPlus(_ sender: Any) {
        
        if valueTotalSelectedUpdate < valueTotalSelected{
            valueTotalSelectedUpdate += 1
        }else if valueTotalSelectedUpdate  >= valueTotalSelected{
             alertShow(title: "", message: "Over selected item", controller: self)
        }
        labelValueSelected.text = "\(valueTotalSelectedUpdate)"
    }
    
    @IBAction func pressDismiss(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
}
