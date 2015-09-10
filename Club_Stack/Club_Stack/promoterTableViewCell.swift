//
//  promoterTableViewCell.swift
//  Club_Stack
//
//  Created by SRIKARTHIK on 03/09/2015.
//  Copyright (c) 2015 Clykx. All rights reserved.
//

import UIKit

class promoterTableViewCell: UITableViewCell {

    @IBOutlet var promoImage: UIImageView!
    @IBOutlet var proUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
