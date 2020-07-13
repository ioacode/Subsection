//
//  ViewController.swift
//  Yups
//
//  Created by balcomm on 23/06/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import UIKit
import PopupDialog
import Presentr
import SwiftyJSON

func alertShow(title:String,message:String,controller:UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.view.tintColor = UIColor(named: "ColorTextBlue")
    alert.addAction(UIAlertAction(title: "Oke", style: .cancel, handler: nil))
    controller.present(alert, animated: true, completion: nil)
}

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var totalItem: UILabel!
    @IBOutlet weak var tableMenu: UITableView!
    
    var appSession: AppSession?

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
    
    
    var valueTotal: Int = 0
    var valueTotalSelected: Int = 0
    var isScroll = true
    var datajson: JSON?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMenu.delegate = self
        tableMenu.dataSource = self
        
        let initfood = JSON(arrayLiteral: ["name": "nasi pecel", "total": "0"],["name": "nasi kuning", "total": "0"], ["name": "nasi merah", "total": "0"],
                            ["name": "nasi hijau", "total": "0"],["name": "nasi biru", "total": "0"],["name": "nasi nasi hitam", "total": "0"],
                            ["name": "nasi orange", "total": "0"],["name": "nasi cokelat", "total": "0"],["name": "nasi putih", "total": "0"])
        
        let initdrink = JSON(arrayLiteral: ["name": "air putih", "total": "0"],["name": "teh", "total": "0"], ["name": "es degan", "total": "0"],
        ["name": "coffe", "total": "0"],["name": "jus wortel", "total": "0"],["name": "jus tomat", "total": "0"],
        ["name": "jus apukat", "total": "0"],["name": "jus stobery", "total": "0"])
        
        let initdrink2 = JSON(arrayLiteral: ["name": "air putih", "total": "0"],["name": "teh", "total": "0"], ["name": "es degan", "total": "0"],
               ["name": "coffe", "total": "0"],["name": "jus wortel", "total": "0"],["name": "jus tomat", "total": "0"],
               ["name": "jus apukat", "total": "0"],["name": "jus stobery", "total": "0"])
        
        let json = JSON(arrayLiteral: initfood,initdrink, initdrink2)
        let jsonData = JSON(["DrinkFood": json])
        
        datajson = JSON.init(jsonData)
    }
    
    @IBAction func pressMInus(_ sender: Any) {
        if valueTotal == 0 {
            valueTotal = 0
            totalItem.text = "\(valueTotal)"
        }else if valueTotal > 0{
            valueTotal -= 1
            totalItem.text = "\(valueTotal)"
        }
        isScroll = true
        tableMenu.reloadData()
    }
       
    @IBAction func pressPlus(_ sender: Any) {
        valueTotal += 1
        totalItem.text = "\(valueTotal)"
        isScroll = true
        tableMenu.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func didSelectedView(value: Int, position: Int) {
        alertShow(title: "", message: "xxx", controller: self)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let totaldata = datajson!["DrinkFood"].arrayValue
        return totaldata.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablemenucell", for: indexPath) as! tablemenuCell
        cell.labelSumSelected.tag = indexPath.section
        cell.collectionSumMenu.tag = indexPath.section
        cell.menuCanSelect = (indexPath.section + 1) * valueTotal
        cell.datajson = self.datajson
        cell.positionSection = indexPath.section
        cell.viewcontroller = self
        cell.isScroll = isScroll
        cell.awakeFromNib()
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScroll = false
    }
}
