//
//  tablemenuCell.swift
//  Yups
//
//  Created by balcomm on 10/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import UIKit
import SwiftyJSON


class tablemenuCell: UITableViewCell{
    @IBOutlet weak var labelSumSelected: UILabel!
    @IBOutlet weak var collectionSumMenu: UICollectionView!
    
    var viewcontroller: UIViewController?
    
    var menuCanSelect: Int = 0
    var datajson: JSON?
    var positionSection: Int = 0
    var isScroll = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionSumMenu.delegate = self
        collectionSumMenu.dataSource = self
        labelSumSelected.text = "You Can selected \(menuCanSelect)"
        
        
        if isScroll{
            collectionSumMenu.reloadData()
        }
    }
}

extension tablemenuCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var totaldata = datajson!["DrinkFood"].arrayValue
        let resultdata = totaldata[positionSection]
        return resultdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionmenucell", for: indexPath) as! collectionmenuCell
        cell.viewcontroller = self.viewcontroller
        cell.menuCanSelect = self.menuCanSelect
        cell.positionSection = self.positionSection
        cell.buttonPlus.tag = indexPath.item
        AppSession().destroySessionMenu(key: "\(self.positionSection)")
        cell.labelTitle.text = datajson!["DrinkFood"][positionSection][indexPath.item]["name"].stringValue 
        cell.awakeFromNib()
        return cell
    }
}

extension tablemenuCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 - 20 , height: collectionView.bounds.width / 3 - 8 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
}
