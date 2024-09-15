//
//  AvatarCell.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class AvatarCell: UITableViewCell {
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ image: UIImage?, _ name: String) {
        self.avatar.frame.size = CGSize(width: 50, height: 50)
        self.avatar.image = image
        self.name.text = name
        
    }
    
}
