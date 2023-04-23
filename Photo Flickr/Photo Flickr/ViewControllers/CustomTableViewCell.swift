//
//  CustomTableViewCell.swift
//  Photo Flickr
//
//  Created by Al-Amin on 2023/04/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    static let identifier = "cell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
