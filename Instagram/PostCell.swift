//
//  PostCellTableViewCell.swift
//  Instagram
//
//  Created by Victoria Zhou on 3/12/17.
//  Copyright © 2017 Victoria Zhou. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post : Post! {
        didSet{
            //let pfObj = post.pfObject
            self.postImageView.file = post.media
            self.postImageView.loadInBackground()
            
            self.captionLabel.text = post.caption
            print(post.caption ?? "no caption")
            print(captionLabel.text ?? "lols what")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
