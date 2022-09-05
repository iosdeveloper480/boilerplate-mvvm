//
//  MessagesResponse.swift
//  Asmaky
//
//  Created by EDS on 21/01/2022.
//

import Foundation

struct MessagesResponse: Codable {
    var success: Bool
//    var trip: UserTripModel
//    var messages: [MessageModel]
//    
//    var status: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case success, trip, messages, status
//    }
//    
//    init(from decoder: Decoder) throws {
//        func get<V: Codable>(from decoder: Decoder = decoder,
//                             _ type: V.Type,
//                             forKey: CodingKeys) throws -> V? {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            if let value = try? values.decode(V.self,
//                                              forKey: forKey) {
//                return value
//            } else {
//                return nil
//            }
//        }
//        self.trip = UserTripModel()
//        self.messages = []
//        self.success = false
//        self.status = 0
//        
//        if let singleVenue = try? get(UserTripModel.self,
//                                      forKey: .trip) {
//            self.trip = singleVenue
//        }
//        
//        if let messagesList = try? get(MessageModel.self,
//                                       forKey: .messages) {
//            self.messages.append(messagesList)
//        } else if let messagesList = try? get([MessageModel].self,
//                                              forKey: .messages) {
//            self.messages = messagesList
//        }
//        
//        if let success = try? get(Bool.self,
//                                  forKey: .success) {
//            self.success = success
//        }
//        
//        if let status = try? get(Int.self,
//                                 forKey: .status) {
//            self.status = status
//        } else if let status = try? get(String.self,
//                                        forKey: .status) {
//            self.status = Int(status)
//        }
//    }
}
