//
//  Models.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 8/10/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import Foundation

struct Root: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
    let url: URL
    
}

struct RestaurantListViewModel {
    let name: String
    let imageUrl: URL
    let distance: Double
    let id: String
    let url: URL
    
    static var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf
    }
    
    var formattedDistance: String? {
        return RestaurantListViewModel.numberFormatter.string(from: distance as NSNumber)
    }
}

extension RestaurantListViewModel {
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = business.distance / 1609.344
        self.url = business.url
    }
}
