//
//  User.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import Foundation

class User {
    
    var firstname: String
    var lastname: String
    var fullname: String
    var age: UInt? = nil
    var photos: [String]? = nil
    
    init(name: String, surname: String, age: UInt, photosArr: [String]) {
        self.firstname = name
        self.lastname = surname
        self.age = age
        self.photos = photosArr
        self.fullname = "\(lastname) \(firstname)"
    }
    
    init() {
        self.firstname = ""
        self.lastname = ""
        self.fullname = "\(lastname) \(firstname)"
    }
    
    deinit {
        print("Item of User have deinitialized")
    }
}

//struct FriendsResponse {
//    let response: Friends
//}
//
//extension FriendsResponse: Codable {
//    enum CodingKeys: String, CodingKey {
//        case response
//    }
//}
//
//
//struct Friends {
//    let count: Int
//    let items: [User]
//}
//
//extension Friends: Codable {
//    enum CodingKeys: String, CodingKey {
//        case count
//        case items
//    }
//}
//
//struct User {
//    let id: Int
//    let firstName: String
//    let lastName: String
//    let photo: String
//    let photo100: String
//    let photo200: String
//}
//
//extension User: Codable {
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case photo = "photo_50"
//        case photo100 = "photo_100"
//        case photo200 = "photo_200"
//    }
//}
