//
//  News.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import Foundation
import UIKit

protocol PropertyLoopable
{
    func allProperties() throws -> [String: Any]
}

extension PropertyLoopable
{
    func allProperties() throws -> [String: Any] {

        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        guard
            let style = mirror.displayStyle,
            style == .struct || style == .class
        else {
            //throw some error
            throw NSError(domain: "hris.to", code: 777, userInfo: nil)
        }

        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }
            
            result[label] = valueMaybe
        }

        return result
    }
}

struct Title {
    var avatar: UIImage?
    var name: String
    
    init(_ avatar: UIImage?, _ name: String) {
        self.avatar = avatar
        self.name = name
    }
}

struct ActionsData {
    var likes: Int?
    var comments: Int?
    var sends: Int?
    var views: Int?
    
    init(_ likes: Int, _ comments: Int, _ sends: Int, _ views: Int) {
        self.likes = likes
        self.comments = comments
        self.sends = sends
        self.views = views
    }
    
    init() {
        self.likes = -1
        self.comments = -1
        self.sends = -1
        self.views = -1
    }
}



class News: PropertyLoopable {
    
    var title: Title?
    var description: String?
    var contentImage: UIImage?
    var dataOfActions: ActionsData?
    
    init(_ title: Title?, _ description: String?, _ contentImage: UIImage?, _ actionsData: ActionsData?) {
        self.title = title
        self.description = description
        self.contentImage = contentImage
        self.dataOfActions = actionsData
    }
    
    init() {
        
    }
    
    deinit {
        print("Item of News have deinitialized")
    }
}

