//
//  GroupCell.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

final class GroupCell: UITableViewCell {

    @IBOutlet weak var groupEmblem: AvatarImage!
    @IBOutlet weak var groupName: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        super.touchesBegan(touches, with: event)
        
        if (touches.first?.view == groupEmblem.superview) {
            animateTapForImage()
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let delay = 0.6
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    super.touchesEnded(touches, with: event)
        })

    }
    
    
    func configure(
        emblem: UIImage,
        name: String) {
            self.groupName.text = name
            self.groupEmblem.image = emblem
        }
    
    func animateTapForImage() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 10,
            options: [
                .curveEaseInOut,
                
            ],
            animations: {
                self.groupEmblem.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { elem in
                UIView.animate(
                    withDuration: 1,
                    delay: 0,
                    usingSpringWithDamping: 0.2,
                    initialSpringVelocity: 10,
                    options: [
                        .curveEaseInOut,
                    ],
                    animations: {
                        self.groupEmblem.transform = CGAffineTransform(scaleX: 1, y: 1)
                    },
                    completion: { elem in
                        
                    })
            })
    }
    
}
