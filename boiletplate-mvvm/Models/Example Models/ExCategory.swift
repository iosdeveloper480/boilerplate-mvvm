//
//	ExCategory.swift
//

import Foundation

struct ExCategory: Codable, WAHashable {
    var id = UUID()
    
	let hide: String?
	let idx: String?
	let img: String?
	let name: String?
	let nameAr: String?
    let total: String?

    let products: [ExProduct]?
    let sliders: [ExSlider]?

	enum CodingKeys: String, CodingKey {
		case hide = "hide"
		case id = "id"
		case img = "img"
		case name = "name"
		case nameAr = "name_ar"
		case products = "products"
		case sliders = "sliders"
		case total = "total"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hide = try values.decodeIfPresent(String.self, forKey: .hide)
		idx = try values.decodeIfPresent(String.self, forKey: .id)
		img = try values.decodeIfPresent(String.self, forKey: .img)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		nameAr = try values.decodeIfPresent(String.self, forKey: .nameAr)
		products = try values.decodeIfPresent([ExProduct].self, forKey: .products)
		sliders = try values.decodeIfPresent([ExSlider].self, forKey: .sliders)
		total = try values.decodeIfPresent(String.self, forKey: .total)
	}
}
