//
//  User.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

struct User: Codable{
    var eid: String
    var user: UserInfo
}

struct UserInfo: Codable{
    var name: String
    var id: Int
    
    enum CodingKeys: String, CodingKey{
        case name = "nm"
        case id
    }
}
