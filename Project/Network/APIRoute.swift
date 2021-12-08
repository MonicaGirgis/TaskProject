//
//  APIRoute.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

class APIRoute{
    
    class func fetchRequest<T: Codable>(clientRequest: ProjectNetwork, decodingModel: T.Type, completion: @escaping (Result<T, Error>) -> ()){
        var components = URLComponents(string: clientRequest.base)!
        components.path = "/" + clientRequest.path
        components.queryItems = clientRequest.queryItems
        
        guard let url = components.url else { return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = clientRequest.method.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard response != nil, let data = data else { return}
            var responseObject: T!
            DispatchQueue.main.async {
                do {
                    responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                }catch let err{
                    completion(.failure(err))
                }
            }
        }
        dataTask.resume()
    }
}
