//
//  subchartMultiCollectionCell.swift
//  Yups
//
//  Created by balcomm on 08/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import UIKit

class subchartMultiCollectionCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var labelValueInsert: UILabel!
    @IBOutlet weak var buttonPlus: UIButton!
    
    var viewcontroller: UIViewController?
    
    var positionSection: Int = 0
    var menuCanSelect: Int = 0
    var index: Int = 0
    var maxIndex: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        labelValueInsert.text = "\(0)"
        index = 0
        maxIndex = 0
        labelValueInsert.isHidden = true
        buttonMinus.isHidden = true
        AppSession().destroySessionSubmenu(key: "\(positionSection)")
    }
     
    @IBAction func pressMinus(_ sender: Any) {
      let maxSelect = Int(AppSession().getSessionSubmenu(key: "\(positionSection)"))
      if maxSelect! <= 1 {
        labelValueInsert.isHidden = true
        buttonMinus.isHidden = true
        index = 0
        AppSession().destroySessionSubmenu(key: "\(positionSection)")
      }else{
          index -= 1
          maxIndex = Int(AppSession().getSessionSubmenu(key: "\(positionSection)"))!
          maxIndex -= 1
          
          if maxIndex <= 0 {
              AppSession().updateSessionSubmenu(value: "\(0)", key: "\(positionSection)")
              labelValueInsert.isHidden = true
              buttonMinus.isHidden = true
          }else{
              AppSession().updateSessionSubmenu(value: "\(maxIndex)", key: "\(positionSection)")
          }
          
          if index == 0{
            labelValueInsert.isHidden = true
            buttonMinus.isHidden = true
            AppSession().destroySessionSubmenu(key: "\(positionSection)")
          }else{
              labelValueInsert.isHidden = false
              buttonMinus.isHidden = false
          }
      }
      labelValueInsert.text  = "\(index)"
    }
    
    @IBAction func pressPlus(_ sender: Any) {
        if AppSession().issubmenuLogin(key: "\(positionSection)"){
            let maxSelect = Int(AppSession().getSessionSubmenu(key: "\(positionSection)"))
            if maxSelect! >= menuCanSelect{
                alertShow(title: "", message: "Over Selected", controller: viewcontroller!)
            }else{
                index += 1
                maxIndex = Int(AppSession().getSessionSubmenu(key: "\(positionSection)"))!
                maxIndex += 1
                AppSession().updateSessionSubmenu(value: "\(maxIndex)", key: "\(positionSection)")

                labelValueInsert.isHidden = false
                buttonMinus.isHidden = false
            }
        }else{
            index += 1
            maxIndex += 1
            AppSession().createSessionSubmenu(value: "\(maxIndex)", key: "\(positionSection)")
            labelValueInsert.isHidden = false
            buttonMinus.isHidden = false
        }
        labelValueInsert.text = "\(index)"
    }
    
}
