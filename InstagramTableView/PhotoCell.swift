//
//  PhotoCell.swift
//  InstagramTableView
//
//  Created by Michael Ellison on 10/27/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var imageCaption: UILabel!
    @IBOutlet weak var photoView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
