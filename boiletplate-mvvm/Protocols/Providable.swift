//
//  Providable.swift
//  FATIMA
//
//  Created by EDS on 12/07/2022.
//

import Foundation

protocol Providable {
    associatedtype ProvidedItem: Hashable
    func provide(_ item: ProvidedItem)
}
