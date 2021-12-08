//
//  Spec.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

struct Params: Codable{
    var force: Int = 1
    var flags: Int32 = 13644935
    var from: Int = 0
    var to: Int = 10000
}

struct SpecModel: Codable{
    var spec: Spec = Spec()
}

struct Spec: Codable{
    var itemsType: String = "avl_unit"
    var propName: String = "sys_name"
    var propValueMask: String = "*"
    var sortType: String = "sys_name"
}
