//
//  NetworkResponse.swift
//  Asmaky
//
//  Created by EDS on 23/12/2021.
//

import Foundation
import Combine

struct NetworkResponse<Wrapped: Codable>: Codable {
    var success: Bool
    var data: [Wrapped]
    var categories: [Wrapped]
    var coupon: Wrapped?
    
    var balance: String
    var tripid: Int?
    
    enum CodingKeys: String, CodingKey {
        case success, data, balance, categories, tripid, coupon
    }
    
    init(from decoder: Decoder) throws {
        func get<V: Codable>(from decoder: Decoder = decoder,
                             _ type: V.Type,
                             forKey: CodingKeys) throws -> V? {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            if let value = try? values.decode(V.self, forKey: forKey) {
                return value
            } else {
                return nil
            }
        }
        data = []
        categories = []
        self.success = false
        self.balance = "0"
        self.tripid = 0
        
        if let singleVenue = try? get(Wrapped.self,
                                      forKey: .data) {
            data.append(singleVenue)
        } else if let multiVenue = try? get([Wrapped].self,
                                            forKey: .data) {
            data = multiVenue
        } else if let categoriesList = try? get(Wrapped.self,
                                                forKey: .categories) {
            self.categories.append(categoriesList)
        } else if let categoriesList = try? get([Wrapped].self,
                                                forKey: .categories) {
            self.categories = categoriesList
        }
        
        if let success = try? get(Bool.self,
                                  forKey: .success) {
            self.success = success
        }
        
        if let balance = try? get(String.self,
                                  forKey: .balance) {
            self.balance = balance
        }
        
        if let tripid = try? get(Int.self,
                                 forKey: .tripid) {
            self.tripid = tripid
        }
        if let coupon = try get(Wrapped.self, forKey: .coupon) {
            self.coupon = coupon
        }
    }
}

struct SuccessResponse: Codable {
    var success: Bool
    enum CodingKeys: String, CodingKey {
        case success
    }
}
