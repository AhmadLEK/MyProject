//
//  Singleton.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 16.08.2024.
//

final class DataStorage {
    
    var token: String = ""
    var userID: Int = 0
    
    static let data = DataStorage()
    
    private init () {}
}
