//
//  PhotoCell.swift
//  Facebook
//
//  Created by Adam Crabtree on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
