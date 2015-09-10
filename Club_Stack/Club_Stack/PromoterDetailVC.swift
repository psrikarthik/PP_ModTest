//
//  PromoterDetailVC.swift
//  Club_Stack
//
//  Created by SRIKARTHIK on 03/09/2015.
//  Copyright (c) 2015 Clykx. All rights reserved.
//

import UIKit

class PromoterDetailVC: UIViewController {

    @IBOutlet var smallImage: UIImageView!
    
    @IBOutlet var prUsername: UILabel!
    
    var img:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let proQuery = PFUser.query()
        proQuery?.whereKey("username", equalTo: img!)
        
        var user = proQuery?.getFirstObject() as! PFUser
        
        let imageFile = user["picture"] as! PFFile
        imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            
            if error == nil {
                if let data = data {
                    //var proImage = UIImage(data: data)
                    self.smallImage.image = UIImage(data: data)
                    
                }
            }
            
        }
        
        
        
//        smallImageView.image = UIImage(named: img!)
//        mainImageView.image = UIImage(named: img!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
