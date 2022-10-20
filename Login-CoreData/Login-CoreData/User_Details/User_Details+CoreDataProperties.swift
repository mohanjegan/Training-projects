//
//  User_Details+CoreDataProperties.swift
//  Login-CoreData
//
//  Created by Mohan on 19/09/22.
//
//

import Foundation
import CoreData


extension User_Details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User_Details> {
        return NSFetchRequest<User_Details>(entityName: "User_Details")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User_Details : Identifiable {

}
