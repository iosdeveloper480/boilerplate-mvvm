//
//  FirebaseNotification.swift
//  Asmaky
//
//  Created by EDS on 16/01/2022.
//

import Foundation
import Alamofire

class FirebaseNotification {
    private let url = "https://fcm.googleapis.com/fcm/send"
    private let authkey = "AUTH_KEY"
    
    func sendNotification(params: [String: Any]?,
                          completion: @escaping (_ success: FirebaseResponse?) -> Void) {
        
        let authHeader = HTTPHeader.authorization(authkey)
        let contentTypeHeader = HTTPHeader.contentType("application/json")
        
        let headers = HTTPHeaders([authHeader, contentTypeHeader])
        APIClient.shared.post(model: FirebaseResponse.self,
                              url: url,
                              headers: headers,
                              params: params) { response in
            if let response = response.value,
               response.success == 1 {
                completion(response)
            } else {
                completion(nil)
            }
        }
    }
}


struct FirebaseResponse: Codable {
    var multicast_id: Double
    var success: Int
    var failure: Int
    var canonical_ids: Int
    var results: [FirebaseResult]
    
    enum CodingKeys: String, CodingKey {
        case multicast_id
        case success
        case failure
        case canonical_ids
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = []
        self.success = 0
        self.multicast_id = 0
        self.failure = 0
        self.canonical_ids = 0
        
        if let singleVenue = try? values.decode(FirebaseResult.self,
                                                forKey: CodingKeys.results) {
            results.append(singleVenue)
        } else if let multiVenue = try? values.decode([FirebaseResult].self,
                                                      forKey: CodingKeys.results) {
            results = multiVenue
        }
        
        if let success = try? values.decode(Int.self,
                                            forKey: CodingKeys.success) {
            self.success = success
        }
        if let failure = try? values.decode(Int.self, forKey: CodingKeys.failure) {
            self.failure = failure
        }
        if let multicast_id = try? values.decode(Double.self, forKey: CodingKeys.multicast_id) {
            self.multicast_id = multicast_id
        }
        if let canonical_ids = try? values.decode(Int.self, forKey: CodingKeys.canonical_ids) {
            self.canonical_ids = canonical_ids
        }
    }
}
struct FirebaseResult: Codable {
    var message_id: String
    enum CodingKeys: String, CodingKey {
        case message_id
    }
}
