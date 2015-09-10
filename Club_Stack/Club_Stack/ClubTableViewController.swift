//
//  ClubTableViewController.swift
//  Club_Stack
//
//  Created by SRIKARTHIK on 01/09/2015.
//  Copyright (c) 2015 Clykx. All rights reserved.
//

import UIKit

class ClubTableViewController: PFQueryTableViewController {
    
    //Initializing the PFQueryTable Tableview
    
     convenience override init(style: UITableViewStyle, className: String!){
    self.init(style: style, className: className)
        
        self.parseClassName = "Club"
        
        self.textKey = "ClubName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false

        
    }

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   
    }
    
    override func queryForTable() -> PFQuery {
        
        var query = PFQuery(className: "Club")
        
       
        return query
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        
        if cell == nil {
            
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
        }
        
        if let clubName = object?["ClubName"] as? String {
            
            cell?.textLabel?.text = clubName
            
        }
           
    return cell
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var detailScene = segue.destinationViewController as! PromoterVC
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){
        
            let row = Int(indexPath.row)
        
        detailScene.currentObject = (objects?[row] as! PFObject)
            
        }
        
    }
    
}

  