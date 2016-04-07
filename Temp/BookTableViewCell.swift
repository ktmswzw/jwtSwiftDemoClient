//
//  BookTableViewCell.swift
//  Temp
//
//  Created by vincent on 4/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBOutlet var id: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!


}