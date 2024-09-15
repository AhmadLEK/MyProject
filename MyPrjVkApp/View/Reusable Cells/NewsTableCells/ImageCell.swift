//
//  ImageCell.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ image: UIImage?) {
        self.myImage.image = image
    }
    
}
