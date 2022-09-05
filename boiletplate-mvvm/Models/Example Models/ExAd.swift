//
//	ExAd.swift
//
import Foundation

struct ExAd: WAHashable, Codable {
    var id = UUID()
    
	let address: String?
	let adsCat: String?
	let conditions: String?
	let date: String?
	let delivery: String?
	let details: String?
	let disable: String?
	let hide: String?
	let idx: String?
	let img: String?
	let name: String?
	let phone: String?
	let price: String?
	let status: String?
	let type: String?
	let uDate: String?
	let userId: String?
	let view: String?

	enum CodingKeys: String, CodingKey {
		case address = "address"
		case adsCat = "ads_cat"
		case conditions = "conditions"
		case date = "date"
		case delivery = "delivery"
		case details = "details"
		case disable = "disable"
		case hide = "hide"
		case id = "id"
		case img = "img"
		case name = "name"
		case phone = "phone"
		case price = "price"
		case status = "status"
		case type = "type"
		case uDate = "u_date"
		case userId = "user_id"
		case view = "view"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		adsCat = try values.decodeIfPresent(String.self, forKey: .adsCat)
		conditions = try values.decodeIfPresent(String.self, forKey: .conditions)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		delivery = try values.decodeIfPresent(String.self, forKey: .delivery)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		disable = try values.decodeIfPresent(String.self, forKey: .disable)
		hide = try values.decodeIfPresent(String.self, forKey: .hide)
		idx = try values.decodeIfPresent(String.self, forKey: .id)
		img = try values.decodeIfPresent(String.self, forKey: .img)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		uDate = try values.decodeIfPresent(String.self, forKey: .uDate)
		userId = try values.decodeIfPresent(String.self, forKey: .userId)
		view = try values.decodeIfPresent(String.self, forKey: .view)
	}
}
