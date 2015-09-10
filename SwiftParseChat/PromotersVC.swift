//
//  PromotersVC.swift
//  
//
//  Created by Karthik on 04/09/2015.
//
//

import UIKit

class PromotersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var currentObject: PFObject!
    
    var match: String?
    
    @IBOutlet var clubLogoImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    var selectedLabel:String?

    var images = [UIImage]()
    
    var promoterArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cImageFile = currentObject["clubLogo"] as! PFFile
            cImageFile.getDataInBackgroundWithBlock { (imageData, error) -> Void in
                
                if error == nil {
                    if let imageData = imageData {
                        self.clubLogoImage?.image = UIImage(data: imageData)
                        
                    }
                    
                }
        }
        promoterArray = currentObject["promoters"] as! [String]
        println(promoterArray)
        for promoter in promoterArray {
            
            let uQuery = PFUser.query()!
            uQuery.whereKey("username", equalTo: promoter)
            var pUser = uQuery.getFirstObject() as! PFUser
            let imageFile = pUser["picture"] as! PFFile
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                
                if error == nil {
                    if let data = data {
                        self.images.append(UIImage(data: data)!)
                        self.tableView.reloadData()
                        
                    }
                }
                
            })
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return promoterArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let pCell = tableView.dequeueReusableCellWithIdentifier("promoCell") as! PromoterTableCell
        
        pCell.promoterNameLabel.text = self.promoterArray[indexPath.row] as String
        
        //pCell.textLabel?.text = self.promoterArray[indexPath.row] as String
        
        if images.count > indexPath.row {
            
            pCell.promoterImage?.image = images[indexPath.row]
            
        }
        
        
        return pCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow()
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! PromoterTableCell!
        
        selectedLabel = currentCell.promoterNameLabel.text
        
         match = self.promoterArray[indexPath!.row]
        
        performSegueWithIdentifier("detailSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath!, animated: true)
        
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailSegue") {
            
            var VC = segue.destinationViewController as! PromoterDetailsVC
            VC.img = selectedLabel
        
            
        }
        
        
        
    }

}
