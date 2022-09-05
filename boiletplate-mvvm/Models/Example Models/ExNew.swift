//
//	ExNew.swift
//

import Foundation

struct ExNew: Codable, WAHashable {
    var id = UUID()
	let address: String?
	let brands: String?
	let cname: String?
	let cnameAr: String?
	let country: String?
	let details: String?
	let fixed: String?
	let idx: String?
	let img: String?
	let menuCat: String?
	let name: String?
	let nameAr: String?
	let phone: String?
	let price: String?
	let quantity: String?
	let rate: String?
	let shopId: String?
	let shopName: String?
	let shopNameAr: String?
	let sname: String?
	let snameAr: String?
	let subId: String?
	let weight: String?

	enum CodingKeys: String, CodingKey {
		case address = "address"
		case brands = "brands"
		case cname = "cname"
		case cnameAr = "cname_ar"
		case country = "country"
		case details = "details"
		case fixed = "fixed"
		case id = "id"
		case img = "img"
		case menuCat = "menu_cat"
		case name = "name"
		case nameAr = "name_ar"
		case phone = "phone"
		case price = "price"
		case quantity = "quantity"
		case rate = "rate"
		case shopId = "shop_id"
		case shopName = "shop_name"
		case shopNameAr = "shop_name_ar"
		case sname = "sname"
		case snameAr = "sname_ar"
		case subId = "sub_id"
		case weight = "weight"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		brands = try values.decodeIfPresent(String.self, forKey: .brands)
		cname = try values.decodeIfPresent(String.self, forKey: .cname)
		cnameAr = try values.decodeIfPresent(String.self, forKey: .cnameAr)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		fixed = try values.decodeIfPresent(String.self, forKey: .fixed)
		idx = try values.decodeIfPresent(String.self, forKey: .id)
		img = try values.decodeIfPresent(String.self, forKey: .img)
		menuCat = try values.decodeIfPresent(String.self, forKey: .menuCat)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		nameAr = try values.decodeIfPresent(String.self, forKey: .nameAr)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
		rate = try values.decodeIfPresent(String.self, forKey: .rate)
		shopId = try values.decodeIfPresent(String.self, forKey: .shopId)
		shopName = try values.decodeIfPresent(String.self, forKey: .shopName)
		shopNameAr = try values.decodeIfPresent(String.self, forKey: .shopNameAr)
		sname = try values.decodeIfPresent(String.self, forKey: .sname)
		snameAr = try values.decodeIfPresent(String.self, forKey: .snameAr)
		subId = try values.decodeIfPresent(String.self, forKey: .subId)
		weight = try values.decodeIfPresent(String.self, forKey: .weight)
	}
}
