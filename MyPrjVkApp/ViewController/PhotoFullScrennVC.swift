//
//  PhotoFullScrennVC.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class PhotoFullScrennVC: UIViewController {
    
    var photos: [String] = ["caption1"]
    var currentIndex: Int? = nil
    var personName: String = " "
    let duration: CGFloat = 1
    private var propertyAnimatorToTheRight: UIViewPropertyAnimator!
    private var propertyAnimatorToTheLeft: UIViewPropertyAnimator!

    @IBOutlet var Container: UIView!
    @IBOutlet var imageView: UIImageView!
    var leftImageView: UIImageView!
    var rightImageView: UIImageView!
    
    
    
    func checkIndex(Index: Int, previous: inout Int, next: inout Int) {
        if ((Index - 1) < 0) {
            previous = (photos.count) - 1
            next = Index + 1
        } else if ((Index + 1) > photos.count - 1) {
            previous = Index - 1
            next = 0
        } else {
            previous = Index - 1
            next = Index + 1
        }
    }
    
    func setCurrentIndex(myIndex: inout Int, nextValue: Int) {
        if (nextValue < 0) {
            myIndex = (photos.count) - 1
        } else if (nextValue > photos.count - 1) {
            myIndex = 0
        } else {
            myIndex = nextValue
        }
    }
    
    @objc
    func didPan(_ gesture: UIPanGestureRecognizer) {
        
        let scaleForSideImage = 0.7
        let leftImageViewWidth = Container.bounds.width * scaleForSideImage
        var leftImageViewHeight = 0
        
        let rightImageViewWidth = Container.bounds.width * scaleForSideImage
        var rightImageViewHeight = 0
        
        switch gesture.state {
        case .began:
            
            var previousIndex: Int = 0
            var nextIndex: Int = 0
            
           
            
            var widthOfImage: CGFloat?
            var heightOfImage: CGFloat?
            var ratio: CGFloat
            
            checkIndex(Index: currentIndex!, previous: &previousIndex, next: &nextIndex)
            
            let leftImage = UIImage(named: "Collections/\(personName)/\(photos[previousIndex])")
            widthOfImage = leftImage?.size.width
            heightOfImage = leftImage?.size.height
            ratio = heightOfImage! / widthOfImage!
            leftImageViewHeight = Int(leftImageViewWidth) * Int(ratio)
            
            let rightImage = UIImage(named: "Collections/\(personName)/\(photos[nextIndex])")
            widthOfImage = rightImage?.size.width
            heightOfImage = rightImage?.size.height
            ratio = heightOfImage! / widthOfImage!
            rightImageViewHeight = Int(rightImageViewWidth) * Int(ratio)
            
            
            
            leftImageView = UIImageView(frame: CGRect(
                x: -Int(self.Container.bounds.width) + Int(self.Container.bounds.width - leftImageViewWidth) / 2,
                y: Int(self.Container.bounds.midY) - Int(leftImageViewHeight / 2),
                width: Int(leftImageViewWidth),
                height: leftImageViewHeight))//leftImage?.size.height ?? Container.bounds.height))
            leftImageView.image = leftImage
            
            
            rightImageView = UIImageView(frame: CGRect(
                x: self.Container.bounds.width + (self.Container.bounds.width - rightImageViewWidth) / 2,
                y: self.Container.bounds.midY - CGFloat(rightImageViewHeight) / 2.0,
                width: rightImageViewWidth,
                height: CGFloat(rightImageViewHeight)))
            rightImageView.image = rightImage
            
            Container.addSubview(leftImageView)
            Container.addSubview(rightImageView)
            
            // прокрутка вправо
            propertyAnimatorToTheRight = UIViewPropertyAnimator(
                duration: duration,
                curve: .linear,
                animations: {
                    // центральный
                    self.assignTransformImageForOne(neededImageView: self.imageView, self.Container.bounds.width)
//                    self.assignTransformImageForOneWithScale(
//                        neededImageView: self.imageView,
//                        self.Container.bounds.width, //self.Container.bounds.width - CGFloat(Int(self.Container.bounds.width - leftImageViewWidth)),
//                        scaleForSideImage,
//                        scaleForSideImage)
                    // левый
                    self.assignTransformImageForOneWithScale(
                        neededImageView: self.leftImageView,
                        self.Container.bounds.width - CGFloat(Int(self.Container.bounds.width - leftImageViewWidth)),
                        1 / scaleForSideImage,
                        1 / scaleForSideImage)
                 
                })
            
            
            // прокрутка влево
            propertyAnimatorToTheLeft = UIViewPropertyAnimator(
                duration: duration,
                curve: .easeInOut,
                animations: {
                    // центральный
                    self.assignTransformImageForOne(neededImageView: self.imageView, 0)
                    //правый
//                    self.assignTransformImageForOne(neededImageView: self.rightImageView, -self.Container.bounds.width)
                    self.assignTransformImageForOneWithScale(
                        neededImageView: self.rightImageView,
                        -self.Container.bounds.width + (self.Container.bounds.width - rightImageViewWidth),
                        1 / scaleForSideImage,
                        1 / scaleForSideImage)
                })
            
            propertyAnimatorToTheRight.pauseAnimation()
            propertyAnimatorToTheLeft.pauseAnimation()
            
        case .changed:
            
            let translation = gesture.translation(in: self.imageView)
            propertyAnimatorToTheRight.fractionComplete = translation.x / 200
            propertyAnimatorToTheLeft.fractionComplete = -translation.x / 200
            
        case .ended:
            
            let progressleft = propertyAnimatorToTheLeft.fractionComplete
            let progressRight = propertyAnimatorToTheRight.fractionComplete
            propertyAnimatorToTheRight.stopAnimation(true)
            propertyAnimatorToTheLeft.stopAnimation(true)
        
            if (progressleft > 0.5) {
                animateScrollImage(-self.Container.bounds.width, 0.5)
                animateScale(
                    myImageView: rightImageView,
                    (-self.Container.bounds.width) + (self.Container.bounds.width - rightImageViewWidth),
                    1 / scaleForSideImage,
                    1 / scaleForSideImage,
                    duration: 0.5)
              
                
                setCurrentIndex(myIndex: &currentIndex!, nextValue: currentIndex! + 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.setImageForAll(
                        left: self.leftImageView,
                        center: self.imageView,
                        right: self.rightImageView,
                        index: self.currentIndex!)
                    self.rightImageView.image = nil
                    self.leftImageView.image = nil
                })
            } else if (progressRight > 0.5) {
                animateScrollImage(self.Container.bounds.width, 0.5)
                animateScale(
                    myImageView: leftImageView,
                    self.Container.bounds.width - CGFloat(Int(self.Container.bounds.width - leftImageViewWidth)),
                    1 / scaleForSideImage,
                    1 / scaleForSideImage,
                    duration: 0.5)
               
                
                setCurrentIndex(myIndex: &currentIndex!, nextValue: currentIndex! - 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.setImageForAll(
                        left: self.leftImageView,
                        center: self.imageView,
                        right: self.rightImageView,
                        index: self.currentIndex!)
                    self.rightImageView.image = nil
                    self.leftImageView.image = nil
                    
                })
            } else {
                animateScrollImage(0, 0.5)
                animateScale(
                    myImageView: leftImageView,
                    0 - CGFloat(Int(self.Container.bounds.width - leftImageViewWidth)),
                    1 ,
                    1 ,
                    duration: 0.5)
                animateScale(
                    myImageView: rightImageView,
                    0 + (self.Container.bounds.width - rightImageViewWidth),
                    1 ,
                    1 ,
                    duration: 0.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.rightImageView.image = nil
                    self.leftImageView.image = nil
                })
                
            }
            
        default:
            return
            
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImage(currentIndex)
        imageView.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:))))
        
    }
    
    func setImage(_ index: Int?) {
        let name: String = photos[self.currentIndex!]
        imageView.image = UIImage(named: "Collections/\(personName)/\(name)")
    }
    
    func setImageForAll(left: UIImageView, center: UIImageView, right: UIImageView, index: Int) {
        center.image = UIImage(named: "Collections/\(personName)/\(photos[self.currentIndex!])")
        self.animateScrollImage(0, 0)
//        self.animateScale(
//            myImageView: rightImageView,
//            (-self.Container.bounds.width) + (self.Container.bounds.width - rightImageViewWidth),
//            1,
//            1,
//            duration: 0.5)
        assignTransformImageForOne(neededImageView: rightImageView, Container.bounds.width)
        assignTransformImageForOne(neededImageView: leftImageView, -Container.bounds.width)
        
        
        var previous = 0
        var next = 0
        
        checkIndex(Index: currentIndex!, previous: &previous, next: &next)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            left.image = UIImage(named: "Collections/\(self.personName)/\(self.photos[previous])r")
            right.image = UIImage(named: "Collections/\(self.personName)/\(self.photos[next])")
        })
        
    }
    
    
    func assignTransformImageForOne(neededImageView: UIImageView, _ x: CGFloat) {
        let transform = CGAffineTransform(
            translationX: x,
            y: Container.bounds.minY)
        neededImageView.transform = transform
    }
    
    
    func assignTransformImageForOneWithScale(neededImageView: UIImageView, _ x: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat) {
        let transform = CGAffineTransform(
            translationX: x,
            y: Container.bounds.minY)
        let scaleTransform = CGAffineTransform(
            scaleX: scaleX,
            y: scaleY)
        
        neededImageView.transform = transform.concatenating(scaleTransform)
    }
    
    
    func animateScale(myImageView: UIImageView, _ x: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, duration: CGFloat) {
        UIView.animate(
            withDuration: duration,
            animations: {
                let transform = CGAffineTransform(
                    translationX: x,
                    y: self.Container.bounds.minY)
                let transformScale = CGAffineTransform(
                    scaleX: scaleX,
                    y: scaleY)
                myImageView.transform = transform.concatenating(transformScale)
            })
    }
    func animateScrollImage(_ x: CGFloat, _ duration: CGFloat) {
        UIView.animate(
            withDuration: duration,
            animations: {
                let transform = CGAffineTransform(
                    translationX: x,
                    y: self.Container.bounds.minY)
                self.imageView.transform = transform
            })
//        UIView.animate(
//            withDuration: duration,
//            animations: {
//                let transform = CGAffineTransform(
//                    translationX: x,
//                    y: self.Container.bounds.minY)
//                self.leftImageView.transform = transform
//            })
//
//        UIView.animate(
//            withDuration: duration,
//            animations: {
//                let transform = CGAffineTransform(
//                    translationX: x,
//                    y: self.Container.bounds.minY)
//                self.rightImageView.transform = transform
//            })
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("began")
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("move")
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
