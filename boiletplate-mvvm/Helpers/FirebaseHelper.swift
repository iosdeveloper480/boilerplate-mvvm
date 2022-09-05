//
//  FirebaseHelper.swift
//  Asmaky
//
//  Created by EDS on 20/12/2021.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestore

class FirebaseHelper {
    
    static let shared = FirebaseHelper()
    private let firestore = Firestore.firestore()
    
    func cancelTrip(tripId: String,
                    driverId: String,
                    completionHandler: @escaping (_ status: Bool) -> Void,
                    errorHandler: @escaping (_ error: Error) -> Void) {
        firestore.collection("drivers").document(driverId).updateData(["status": 0,
                                                                       "trip": "0"]) { error in
            if let error = error {
                errorHandler(error)
            } else {
                
            }
        }
    }
    
//    func cancelTrip(tripId: String,
//                    completionHandler: @escaping (_ status: Bool) -> Void,
//                    errorHandler: @escaping (_ error: Error) -> Void) {
//        self.firestore.collection("trips").document(tripId).updateData(["status": 7,
//                                                                        "driver_id": ""]) { error in
//            if let error = error {
//                errorHandler(error)
//            } else {
//                completionHandler(true)
//            }
//        }
//    }
    
    func missedTrip(tripId: String,
                    completionHandler: @escaping (_ status: Bool) -> Void,
                    errorHandler: @escaping (_ error: Error) -> Void) {
        self.firestore.collection("trips").document(tripId).updateData(["status": 8,
                                                                        "driver_id": ""]) { error in
            if let error = error {
                errorHandler(error)
            } else {
                completionHandler(true)
            }
        }
    }
//
//    func getDriverToken(driverId: String,
//                        completionHandler: @escaping (_ driver: DriverModel?,
//                                                      _ error: Error?) -> Void) {
//        firestore.collection("drivers").document(driverId).getDocument { snapshot, error in
//            if let error = error {
//                completionHandler(nil, error)
//            } else {
//                if let snapshot = snapshot {
//                    if let driverDocData = snapshot.data() {
//                        let userTrip = DriverModel(dictionary: driverDocData,
//                                                   documentId: driverId)
//                        completionHandler(userTrip, nil)
//                    } else {
//                        completionHandler(nil, NSError(domain: "com.e-ds.hiroad",
//                                                       code: 400,
//                                                       userInfo: ["message": "No record found."]))
//                    }
//                } else {
//                    completionHandler(nil, nil)
//                }
//            }
//        }
//    }
}
