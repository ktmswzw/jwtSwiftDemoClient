//
//  User.swift
//  Temp
//
//  Created by vincent on 3/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import UIKit

class BookTableViewCell2: UITableViewCell {
    var book: Book{
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}