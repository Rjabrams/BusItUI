//
//  MapTableViewCell.swift
//  SidebarMenu
//
//  Created by Ivan Alvarado on 1/15/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

import UIKit

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView:UIImageView!
    @IBOutlet weak var authorImageView:UIImageView!
    @IBOutlet weak var postTitleLabel:UILabel!
    @IBOutlet weak var authorLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}