//
//  ReviewCell.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/30/21.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewBubble: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var stackBubble: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
