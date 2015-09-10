//
//  PromoterVC.swift
//  Club_Stack
//
//  Created by SRIKARTHIK on 03/09/2015.
//  Copyright (c) 2015 Clykx. All rights reserved.
//

import UIKit

class PromoterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var currentObject: PFObject!
   
    var selectedLabel:String?
    
    
    //var usernames = [String]()
    var images = [UIImage]()
    
     var promoterArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

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
                        
                    }
                }
                
            })
            
//            uQuery.findObjectsInBackgroundWithBlock { (results, error) -> Void in
//                
//                if let results = results {
//                    
//                    for result in results as! [PFUser] {
//                        
//                        //self.usernames.append(result.username!)
//                        
//                        let imageFile = result["picture"] as! PFFile
//                        
//                        imageFile.getDataInBackgroundWithBlock {
//                            (imageData: NSData?, error: NSError?) -> Void in
//                            
//                            if error != nil {
//                                
//                                print(error)
//                                
//                            } else {
//                                
//                                if let data = imageData {
//                                    
//                                    self.images.append(UIImage(data: data)!)
//                                    println("heeehaaa")
//                                 }
//                            }
//                            
//                        }
//                       }
//                   }
//                
//            }
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
        
        let pCell = tableView.dequeueReusableCellWithIdentifier("promoCell") as! promoterTableViewCell
        
        pCell.proUsername.text = self.promoterArray[indexPath.row] as String
        
        println(indexPath.row)
        
            //pCell.textLabel?.text = self.promoterArray[indexPath.row] as String
        
        if images.count > indexPath.row {
            
            pCell.imageView?.image = images[indexPath.row]
            
        }
            
        
        
        return pCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow()
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as! promoterTableViewCell!
        
        selectedLabel = currentCell.proUsername.text
        
        
        performSegueWithIdentifier("detailSegue", sender: self)
        
        
        
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailSegue") {
            
            var VC = segue.destinationViewController as! PromoterDetailVC
            VC.img = selectedLabel
            
        }
        
        
        
    }

}
