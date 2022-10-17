//
//  UserInfo.swift
//  Http-Methods
//
//  Created by Mohan on 14/10/22.
//

import Foundation

struct UserList {
    var userInfo = [UserInfo]()
    
//    init(array:Array<Any>) {
//        array.forEach { (user) in
//            userInfo.append(UserInfo(dictionary: user as! NSDictionary))
//        }
//    }
}
struct UserInfo: Codable {
    let createdAt: String?
    let name: String?
    let avatar: String?
    let id: String?
    
//    init(dictionary: NSDictionary) {
//        self.createdAt = dictionary.value(forKey: "createdAt") as? String
//        self.name = dictionary.value(forKey: "name") as? String
//        self.avatar = dictionary.value(forKey: "avatar") as? String
//        self.id = dictionary.value(forKey: "id") as? String
//    }
}
