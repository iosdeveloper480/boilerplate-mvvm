//
//  UserNetwork.swift
//  Asmaky
//
//  Created by EDS on 23/12/2021.
//

import Foundation
import Alamofire
import Firebase
import FirebaseAuth

class UserNetwork {
    
    typealias handler<V> = (V) -> Void
    
    func loginWithCredentials(username: String,
                              mobileno: String,
                              completionHandler: @escaping ((_ verificationId: String?,
                                                             _ error: Error?) -> Void)) {
        PhoneAuthProvider.provider().verifyPhoneNumber(mobileno, uiDelegate: nil) { (verificationID, error) in
            completionHandler(verificationID, error)
        }
    }
    
    func registerUser(params: [String: Any]?,
                      completion: @escaping handler<UserModel?>) {
        APIClient.shared.post(model: UserModel.self,
                              endPoint: .index,
                              params: params) { response in
            if let user = response.value,
               user.success {
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    func HomeExample(params: [String: Any]?,
                      completion: @escaping handler<Example?>) {
        APIClient.shared.post(model: Example.self,
                              endPoint: .index,
                              params: params) { response in
            if let user = response.value {
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    func joinus(params: [String: Any]?,
                completion: @escaping (_ success: Bool) -> Void) {
        APIClient.shared.post(model: SuccessResponse.self,
                              endPoint: .index,
                              params: params) { response in
            self.successResponse(response: response,
                                 completion: completion)
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func conditions<V: Codable>(response: DataResponse<NetworkResponse<V>, AFError>,
                                        completion: @escaping handler<NetworkResponse<V>?>) {
        if let response = response.value,
           response.success {
            completion(response)
        } else {
            completion(nil)
        }
    }
    
//    private func conditions(response: DataResponse<ActiveTripResponse, AFError>,
//                                        completion: @escaping handler<ActiveTripResponse?>) {
//        if let response = response.value,
//           response.success {
//            completion(response)
//        } else {
//            completion(nil)
//        }
//    }
    
    private func successResponse(response: DataResponse<SuccessResponse, AFError>,
                                 completion: @escaping (_ success: Bool) -> Void) {
        if let response = response.value,
           response.success {
            completion(response.success)
        } else {
            completion(false)
        }
    }
}
