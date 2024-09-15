//
//  SomeCollectionReusableView.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class SomeCollectionReusableView: UICollectionReusableView {

    @IBOutlet var personImage: UIImageView!
    @IBOutlet var firstname: UILabel!
    @IBOutlet var lastname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(personLastname: String, personFirstname: String, personImage: UIImage?) {
        self.lastname.text = personLastname
        self.firstname.text = personFirstname
        self.personImage.image = personImage
    }
    
    
}
