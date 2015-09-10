//
//  promoChatTVCell.swift
//  PP
//
//  Created by SRIKARTHIK on 05/09/2015.
//  Copyright (c) 2015 PartyPal. All rights reserved.
//

import UIKit

class promoChatTVCell: UITableViewCell {
    
    var delegate: PromoterDetailsVCDelegate?
    var data: PFObject?
    
//    @IBAction func didTapMilk() {
//        if let delegate = self.delegate {
//            delegate.didTapMilk(self.data)
//        }
//    }
    
//    @IBAction func chatButton() {
//        
//        if let delegate = self.delegate {
//            
//            self.delegate.chatUser(user: self.user)
//            
//        }
//        
//    }
  
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
