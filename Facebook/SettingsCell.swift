//
//  SettingsCell.swift
//  Facebook
//
//  Created by Adam Crabtree on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var switchView: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
