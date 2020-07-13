//
//  MultipleItemController.swift
//  Yups
//
//  Created by balcomm on 08/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import UIKit
import SwiftyJSON

class MultipleItemController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableviewMenu: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var titleItem: String = ""
    var valueTotalSelected: Int = 0
    var isScroll = true
    var datajson: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewMenu.delegate = self
        tableviewMenu.dataSource = self
        
        labelTitle.text = "~ "+titleItem+" ~"
        
        let initfood = JSON(arrayLiteral: ["name": "pedas", "total": "0"],["name": "manis", "total": "0"], ["name": "asam", "total": "0"],
                                   ["name": "pedas manis", "total": "0"],["name": "extra pedas", "total": "0"],["name": "asam manis", "total": "0"])
        let json = JSON(initfood)
        let jsonData = JSON(["type": json])
        
        datajson = JSON.init(jsonData)
        
    }
    
    @IBAction func pressDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MultipleItemController: UITableViewDelegate, UITableViewDataSource, multichartbDelegate{
    func reloadData(isReload: Bool) {
        if isReload{ 
            tableviewMenu.beginUpdates()
            tableviewMenu.endUpdates()
        }else{
            tableviewMenu.rowHeight = 40
            tableviewMenu.beginUpdates()
            tableviewMenu.endUpdates()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return valueTotalSelected
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subchartmulti", for: indexPath) as! subchartMultiCell
        cell.positionSection = indexPath.section
        cell.buttonHeader.tag = indexPath.section
        cell.viewCollection.tag = indexPath.section
        cell.labelMenu.text = "\(titleItem) Pilihan  \(indexPath.section+1)"
        cell.titleItem = self.titleItem
        cell.viewcontroller = self
        cell.multichartb = self
        cell.datajson = datajson
        cell.tableView = tableviewMenu
        cell.isScroll = isScroll
        cell.awakeFromNib()
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScroll = false
    }
    
}
