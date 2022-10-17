//
//  userViewModel.swift
//  Http-Methods
//
//  Created by Mohan on 14/10/22.
//

import Foundation
import UIKit
class UserViewModel: Codable{
    let createdAt: String?
    let name: String?
    let avatar: String?
    let id: String?
    
    init(withUser user: UserInfo) {
        self.createdAt = user.createdAt ?? ""
        self.name = user.name ?? ""
        self.avatar = user.avatar ?? ""
        self.id = user.id ?? ""
    }
}
