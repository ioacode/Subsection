//
//  subchartMultiCell.swift
//  Yups
//
//  Created by balcomm on 08/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import UIKit
import SwiftyJSON


protocol multichartbDelegate {
    func reloadData(isReload: Bool)
}

class subchartMultiCell: UITableViewCell{
    @IBOutlet weak var labelMenu: UILabel!
    @IBOutlet weak var collectionMenu: UICollectionView!
    @IBOutlet weak var buttonHeader: UIButton!
    @IBOutlet weak var viewCollection: UIView!
    
    var viewcontroller: UIViewController?
    var positionSection: Int = 0
    var titleItem: String = ""
    var multichartb: multichartbDelegate?
   
    var tableView: UITableView?
    var isScroll = false
    var datajson: JSON?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionMenu.dataSource = self
        self.collectionMenu.delegate = self
    
        
        if isScroll{
            collectionMenu.reloadData()
        }
    }
    
    @IBAction func pressHeader(_ sender: Any) {
        if viewCollection.isHidden == true{
            viewCollection.isHidden = false
             
            tableView!.rowHeight = UITableView.automaticDimension
            tableView!.beginUpdates()
            tableView?.endUpdates()
        }else{
            viewCollection.isHidden = true
            
            tableView!.rowHeight = UITableView.automaticDimension
            tableView!.beginUpdates()
            tableView?.endUpdates()
        }
    }
}

extension subchartMultiCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datajson!["type"].arrayValue.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subchartmulticollectioncell", for: indexPath) as! subchartMultiCollectionCell
        cell.labelTitle.text = datajson!["type"][indexPath.item]["name"].stringValue
        cell.viewcontroller = self.viewcontroller
        cell.positionSection = self.positionSection
        cell.awakeFromNib()
        return cell
    }
}

extension subchartMultiCell : UICollectionViewDelegateFlowLayout{
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
