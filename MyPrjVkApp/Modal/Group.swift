//
//  Group.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import Foundation

class Group {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init() {
        self.name = ""
    }
    
    deinit {
        print("Item of Group have deinitialized")
    }
}
