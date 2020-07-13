//
//  collectionmenuCell.swift
//  Yups
//
//  Created by balcomm on 10/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import UIKit
import Presentr

class collectionmenuCell: UICollectionViewCell{
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var labelValueInsert: UILabel!
    @IBOutlet weak var buttonPlus: UIButton!
    
    var viewcontroller: UIViewController?
    
    var positionSection:Int = 0
    var menuCanSelect: Int = 0
    var index: Int = 0
    var maxIndex: Int = 0
    
    let presenter: Presentr = {
          let width = ModalSize.full
          let height = ModalSize.full
          let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
          let customType = PresentationType.custom(width: width, height: height, center: center)

          let customPresenter = Presentr(presentationType: customType)
          customPresenter.transitionType = .coverVerticalFromTop
          customPresenter.dismissTransitionType = .crossDissolve
          customPresenter.roundCorners = false
          customPresenter.backgroundColor = UIColor.lightGray
          customPresenter.backgroundOpacity = 0.2
          customPresenter.dismissOnSwipe = true
          customPresenter.dismissOnSwipeDirection = .bottom
          return customPresenter
      }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelValueInsert.text = "\(0)"
        index = 0
        maxIndex = 0
        labelValueInsert.isHidden = true
        buttonMinus.isHidden = true
    }
    
    @IBAction func pressMenu(_ sender: Any) {
        let valuedata = Int(labelValueInsert.text!)
        
        if valuedata! <= 0 {
            alertShow(title: "", message: "It's not selected", controller: viewcontroller!)
            
        }else if valuedata! == 1 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let controller = story.instantiateViewController(identifier: "singleItem") as? SingleItemController
            controller!.valueTotalSelected = valuedata!
            viewcontroller?.customPresentViewController(presenter , viewController: controller!, animated: true)
            
        }else if valuedata! > 1{
            let story = UIStoryboard(name: "Main", bundle: nil)
            let controller = story.instantiateViewController(identifier: "multipleitem") as? MultipleItemController
            controller!.valueTotalSelected = valuedata!
            controller!.titleItem = labelTitle.text!
            viewcontroller?.customPresentViewController(presenter , viewController: controller!, animated: true)
        }
    }
    
    @IBAction func pressMinus(_ sender: Any) {
        let maxSelect = Int(AppSession().getSessionMenu(key: "\(positionSection)"))
        if maxSelect! <= 1 {
            labelValueInsert.isHidden = true
            buttonMinus.isHidden = true
            index = 0
            maxIndex  = 0
            AppSession().updateSessionMenu(value: "\(maxIndex)", key: "\(positionSection)")
        }else{
            index -= 1
            maxIndex = Int(AppSession().getSessionMenu(key: "\(positionSection)"))!
            maxIndex -= 1
            
            if maxIndex <= 0 {
                AppSession().updateSessionMenu(value: "\(0)", key: "\(positionSection)")
                labelValueInsert.isHidden = true
                buttonMinus.isHidden = true
            }else{
                AppSession().updateSessionMenu(value: "\(maxIndex)", key: "\(positionSection)")
            }
            
            if index == 0{
              labelValueInsert.isHidden = true
              buttonMinus.isHidden = true
            }else{
                labelValueInsert.isHidden = false
                buttonMinus.isHidden = false
            }
            
          
        }
        labelValueInsert.text  = "\(index)"
    }
    
    @IBAction func pressPlus(_ sender: Any) {
        print("---------- section ------------->",positionSection)
        print("---------- sub section ------------->",buttonPlus.tag)
        
        if menuCanSelect == 0 {
            alertShow(title: "", message: "Please Select", controller: viewcontroller!)
        }else{
            if AppSession().ismenuLogin(key: "\(positionSection)"){
                let maxSelect = Int(AppSession().getSessionMenu(key: "\(positionSection)"))
                if maxSelect! >= menuCanSelect{
                    alertShow(title: "", message: "Over Selected", controller: viewcontroller!)
                }else{
                    index += 1
                    maxIndex = Int(AppSession().getSessionMenu(key: "\(positionSection)"))!
                    maxIndex += 1
                    AppSession().updateSessionMenu(value: "\(maxIndex)", key: "\(positionSection)")

                    labelValueInsert.isHidden = false
                    buttonMinus.isHidden = false
                }
            }else{
                index += 1
                maxIndex += 1
                AppSession().createSessionMenu(value: "\(maxIndex)", key: "\(positionSection)")

                labelValueInsert.isHidden = false
                buttonMinus.isHidden = false
                
            }
            labelValueInsert.text = "\(index)"
        }
    }
}
