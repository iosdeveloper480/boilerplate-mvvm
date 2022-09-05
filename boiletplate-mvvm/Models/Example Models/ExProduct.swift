//
//	ExProduct.swift
//

import Foundation

struct ExProduct: WAHashable, Codable {
    var id = UUID()
    
	let brands: String?
	let details: String?
	let fixed: String?
	let idx: String?
	let img: String?
	let name: String?
	let nameAr: String?
	let price: String?
	let shopId: String?
	let subId: String?
	let weight: String?

	enum CodingKeys: String, CodingKey {
		case brands = "brands"
		case details = "details"
		case fixed = "fixed"
		case id = "id"
		case img = "img"
		case name = "name"
		case nameAr = "name_ar"
		case price = "price"
		case shopId = "shop_id"
		case subId = "sub_id"
		case weight = "weight"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		brands = try values.decodeIfPresent(String.self, forKey: .brands)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		fixed = try values.decodeIfPresent(String.self, forKey: .fixed)
		idx = try values.decodeIfPresent(String.self, forKey: .id)
		img = try values.decodeIfPresent(String.self, forKey: .img)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		nameAr = try values.decodeIfPresent(String.self, forKey: .nameAr)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
		subId = try values.decodeIfPresent(String.self, forKey: .subId)
		weight = try values.decodeIfPresent(String.self, forKey: .weight)
	}
}
