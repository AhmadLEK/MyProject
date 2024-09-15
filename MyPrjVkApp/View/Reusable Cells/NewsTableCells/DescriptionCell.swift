//
//  DescriptionCell.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    @IBOutlet var myDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ text: String) {
        myDescription.text = text

    }
    
}
