//
//  PhotoItem.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

final class PhotoItem: UICollectionViewCell {

    private var pressed: Bool = false
    private var amountOfLike: Int = 1
    private var duration = 0.5

    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var imageView: UIView!
            
    @IBOutlet var button: UIButton!
    @IBOutlet var likes: UILabel!
    
    @IBAction func didLikePressed(_ sender: Any) {
        changeState()
    }
    
    var tapGestureRecognize: UIGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(onTap))
        
        recognizer.numberOfTouchesRequired = 1
        recognizer.numberOfTapsRequired = 1
        
        return recognizer
    }()
    
    @objc func onTap() {
        print("Tap")
    }

    
    func configure(image: UIImage?) {
        self.itemImage.image = image
        likes.text = "\(amountOfLike)"

    }
    
    func changeState() {
        pressed = !pressed
        if pressed {
            amountOfLike = amountOfLike + 1
            button.setImage(
                UIImage(systemName: "heart.fill"),
                for: .normal)
            UIView.transition(with: likes ?? UIView(),
                              duration: duration,
                              options: [
                                .transitionFlipFromBottom
                              ],
                              animations: {
                self.likes.text = "\(self.amountOfLike)"
            },
                              completion: { elem in
                
            })
            
            
            button.tintColor = UIColor.red
            likes.textColor = UIColor.red
        } else {
            amountOfLike = amountOfLike - 1
            button.setImage(
                UIImage(systemName: "heart"),
                for: .normal)
            
            UIView.transition(with: likes ?? UIView(),
                              duration: duration,
                              options: [
                                .transitionFlipFromTop
                              ],
                              animations: {
                self.likes.text = "\(self.amountOfLike)"
            },
                              completion: { elem in
                
            })
            
            
            button.tintColor = UIColor.tintColor
            likes.textColor = UIColor.black
        }
    }
}
