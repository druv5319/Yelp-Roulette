//
//  NetworkService.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 8/9/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "c5gTo1jCUqaSJIL5GySNO0Wqkb4SZF-VA9DJYvRFR8pWAmidkQeHhkDU52LcTaHvcNHhCzpO1FBW7IOgVUyRXu5rlPTcNhjHFhI-Fl49vYng-5yucxxuptUISu1NXXYx"

enum YelpService {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double, key: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
            
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, long, key):
                return .requestParameters(parameters: ["latitude": lat, "longitude": long, "term": key, "limit" : 15],  encoding: URLEncoding.queryString)
            }
          
        }
        
        var headers: [String : String]? {
            return ["Authorization" : "Bearer \(apiKey)"]
        }
        

        
        
    }
}
