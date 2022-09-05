//
//  UserTrip.swift
//  Asmaky
//
//  Created by EDS on 18/12/2021.
//

import Foundation

protocol UserTrip {
    var id: String? { get }
    var addressA: String? { get set }
    var addressB: String? { get set }
    var date: String? { get set }
    var distance: Double? { get set }
    var locationA: String? { get set }
    var locationB: String? { get set }
    var name: String? { get set }
    var payment: Int? { get set }
    var phone: String? { get set }
    var status: Int? { get set }
    var time: String? { get set }
    var userId: String? { get set }
    var driverId: String? {get set }
//    var drivers: [DriverModel] { get set }
    
    var createdAt: Date? {get set }
}
