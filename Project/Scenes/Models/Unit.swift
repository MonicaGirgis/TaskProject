//
//  Unit.swift
//  Project
//
//  Created by Monica Girgis Kamel on 06/12/2021.
//

import Foundation

struct Unit: Codable{
    var searchSpec: Spec
    var items: [UnitModel]
}

struct UnitModel: Codable{
    var name: String = ""
    var id: Int = 0
    var position: Position = Position()
    
    enum CodingKeys: String, CodingKey{
        case name = "nm"
        case id
        case position = "pos"
    }
}

struct Position: Codable{
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var speed: Double = 0.0

    enum CodingKeys: String, CodingKey{
        case latitude = "y"
        case longitude = "x"
        case speed = "s"
    }
}
