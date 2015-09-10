//
//  PromoterDetailsVC.swift
//  PP
//
//  Created by Karthik on 04/09/2015.
//  Copyright (c) 2015 PartyPal. All rights reserved.
//

import UIKit

protocol PromoterDetailsVCDelegate {
    func chatUser(user: PFUser)
}

class PromoterDetailsVC: UIViewController {

    
    @IBOutlet var smallImage: UIImageView!
    
    @IBOutlet var totalRecLabel: UILabel!
    @IBOutlet var recButton: UIButton!
    
    
    var img:String?
    var totalRecommendations = [PFObject]()
    
    var item: String?
    
    var delegate : PromoterDetailsVCDelegate?
    
    var userLogged = PFUser.currentUser()
    var user3:PFUser?
    
    @IBOutlet var backImage: UIImageView!
    @IBOutlet var UserName: UILabel!
    
    var recUsers = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
       
        smallImage.layer.masksToBounds = true
        smallImage.layer.cornerRadius = self.smallImage.frame.size.width / 2
        let proQuery = PFUser.query()
        proQuery?.whereKey("username", equalTo: img!)
        
       var user1 = proQuery?.getFirstObject() as! PFUser
        user3 = user1
       
        let imageFile = user1["picture"] as! PFFile
        
        imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            
            if error == nil {
                if let data = data {
                    //var proImage = UIImage(data: data)
                    self.smallImage.image = UIImage(data: data)
                    self.backImage.image = UIImage(data:  data)
                    self.UserName.text = self.img
                    
                }
            }
          }
        
        var count = Int()
        var fQuery  = PFQuery(className: "recommendations")
        //fQuery.whereKey("byUser", equalTo: PFUser.currentUser())
        fQuery.whereKey("toPromoter", equalTo: user3!)
        totalRecommendations = fQuery.findObjects() as! [PFObject]
        self.totalRecLabel.text = "\(totalRecommendations.count) Recommendations"
        
        for rec in totalRecommendations{
            var tempUser = rec["byUser"] as! PFUser!
            recUsers.append(tempUser)
        }
        println(recUsers)
        
      }
    
    
    
       @IBAction func recommendButton(sender: UIButton) {
        
        if userLogged == nil {
            var alert = UIAlertController(title: "Login Failed", message: "Please log in to start a Chat!!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Log Me In", style: UIAlertActionStyle.Default, handler: {action in
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            
           saveRecommend(user3!)
            
        }
        
    }
    @IBAction func performGoal(sender: UIButton) {
        
//        let vc = DucksCVC()
//        
//        
//        vc.matchID = user3!.objectId
//        vc.title = user3!.username
//        
//        navigationController?.pushViewController(vc, animated: true)
        let user1 = PFUser.currentUser()
        if user1 == nil {
            var alert = UIAlertController(title: "Login Failed", message: "Please log in to start a Chat!!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Log Me In", style: UIAlertActionStyle.Default, handler: {action in
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
        let groupId = Messages.startPrivateChat(user1, user2: user3!)
        self.item = groupId
        self.performSegueWithIdentifier("messagesChatSegue", sender: groupId)
            
        }
        
    }
    
    func openChat(groupId: String) {
        self.performSegueWithIdentifier("messagesChatSegue", sender: groupId)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    

    
    if(segue.identifier == "messagesChatSegue") {
        let chatVC = segue.destinationViewController as! ChatViewController
        chatVC.hidesBottomBarWhenPushed = true
        let groupId = sender as! String
        chatVC.groupId = self.item!
    }
    if(segue.identifier == "loginSegue"){
        let loginVC = segue.destinationViewController as! WelcomeViewController
    }
    if(segue.identifier == "scheduleSegue"){
        
        let sVC = segue.destinationViewController as! PromoterScheduleVC
        
        let duleQuery = PFUser.query()
        duleQuery?.whereKey("username", equalTo: img!)
        
        var proUser = duleQuery?.getFirstObject() as! PFUser
        
       sVC.someObject = proUser.objectId
       
        
        
    }
    }
   

}
