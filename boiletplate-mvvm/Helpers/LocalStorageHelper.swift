//
//  LocalStorageHelper.swift
//  Asmaky
//
//  Created by EDS on 08/03/2022.
//

import Foundation

class LocalStorageHelper {
    static let shared = LocalStorageHelper()
    private let cartIdentifier = "Cart"
    
//    func getCart() -> [ShopModel] {
//        if let products = UserDefaults.standard.data(forKey: cartIdentifier) {
//            let cartArray = try! JSONDecoder().decode([ShopModel].self, from: products)
//            return cartArray
//        }
//        return []
//    }
//    func setCart(item: ShopModel) {
//        var localProducts = self.getCart()
//        localProducts.append(item)
//        for product in localProducts {
//            if product.id == item.id {
//                product.adons = item.adons
//            } else {
//                
//            }
//        }
//        if localProducts.count == 0 {
//            let items = try! JSONEncoder().encode([item])
//            UserDefaults.standard.set(items, forKey: cartIdentifier)
//        } else {
//            let products = try! JSONEncoder().encode(localProducts)
//            UserDefaults.standard.set(products, forKey: cartIdentifier)
//        }
//    }
//    func deleteCart(item: ShopModel) -> [ShopModel] {
//        var localProducts = self.getCart()
//        localProducts.removeAll(where: {$0.id == item.id})
//        let products = try! JSONEncoder().encode(localProducts)
//        UserDefaults.standard.set(products, forKey: cartIdentifier)
//        return localProducts
//    }
//    func clearCart() {
//        UserDefaults.standard.set(nil, forKey: cartIdentifier)
//    }
}
