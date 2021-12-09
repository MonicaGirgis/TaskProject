//
//  projectNetwork.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

enum ProjectNetwork{
    case GetUserInformation(token: String)
    case GetUnits(params: String, id: String)
    case GetAddress(position: Coords, id: Int)
    case CalculateSensorsValues(sid: String, unitId: Int)
    
}

extension ProjectNetwork: Endpoint{
    var base: String {
        return "http://gps.tawasolmap.com"
    }
    
    var path: String {
        switch self{
        case .GetAddress:
            return "gis_geocode"
        default:
            return "wialon/ajax.html"
        }
    }
    
    var body: [String: Any]? {
        switch self{
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self{
        case .GetUserInformation(let token):
            return [URLQueryItem(name: "svc", value: "token/login"), URLQueryItem(name: "params", value: "{\"token\":\"\(token)\"}")]
        case .GetUnits(let params, let id):
            return [URLQueryItem(name: "params", value: "{\(params)}"),
                    URLQueryItem(name: "svc", value: "core/search_items"),
                    URLQueryItem(name: "sid", value: id)]
        case .GetAddress(let position, let id):
            return [URLQueryItem(name: "coords", value: "[{\(position.dictionary.queryString)}]"),
                    URLQueryItem(name: "uid", value: "\(id)")]
        case .CalculateSensorsValues(let sid, let unitId):
            return [URLQueryItem(name: "svc", value: "unit/calc_last_message"),
                    URLQueryItem(name: "params", value: "{\"unitId\":\(unitId)}"),
                    URLQueryItem(name: "sid", value: sid)]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
