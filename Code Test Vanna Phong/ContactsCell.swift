//
//  ContactsCell.swift
//  Code Test Vanna Phong
//
//  Created by Vanna Phong on 17/12/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit
import Contacts

class ContactsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
