//
//  SongsService.swift
//  ShuffleSongs
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import Foundation

class SongsService: Service {
    
    func songs(ids: [String], limit: Int = 5, completionHandler:@escaping( (Data?, URLResponse?, Error?) -> Void )) {
        let query = [
            URLQueryItem(name: "id", value: ids.joined(separator: ",")),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        var components = URLComponents(string: "https://us-central1-tw-exercicio-mobile.cloudfunctions.net/lookup")
        components?.queryItems = query
        
        let headers: [String: String] = ["Content-Type": "application/json"]
        
        var request = URLRequest(url: components!.url!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
}
