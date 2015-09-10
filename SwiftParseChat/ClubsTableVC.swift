

import UIKit

class ClubsTableVC: PFQueryTableViewController {
   
    convenience override init(style: UITableViewStyle, className: String!){
        self.init(style: style, className: className)
        
        self.parseClassName = "Club"
        
        self.textKey = "ClubName"
        self.imageKey = "clubLogo"
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
        
        var cell = tableView.dequeueReusableCellWithIdentifier("clubCell") as! ClubPFCell!
        
        if cell == nil {
            
            cell = ClubPFCell(style: UITableViewCellStyle.Default, reuseIdentifier: "clubCell")
            
        }
        
        if let clubName = object?["ClubName"] as? String {
            
            cell?.clubNameLabel?.text = clubName
            
        }
        
        let tempFile = object?["clubLogo"] as! PFFile
        tempFile.getDataInBackgroundWithBlock { (imageData, error) -> Void in
            
            if error == nil {
                
                if let imageData = imageData {
                    
                    cell.cImageView.image = UIImage(data: imageData)
                    
                    // cell?.backgroundView?.backgroundColor = UIColor(patternImage: UIImage(data: imageData)!)
                }
                
            }
            
        }
        //cell?.backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        //cell?.imageView.file = object?["clubLogo"] as! PFImageView
        
        
        
        //cell.imageView.file = [object!.objectForKey(self.imageKey as String!)];
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var detailScene = segue.destinationViewController as! PromotersVC
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){
            
            let row = Int(indexPath.row)
            
            detailScene.currentObject = (objects?[row] as! PFObject)
            
        }
        
    }
    
}

