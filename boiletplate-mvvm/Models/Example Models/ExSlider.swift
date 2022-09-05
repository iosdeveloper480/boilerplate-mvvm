//
//	ExSlider.swift
//

import Foundation

struct ExSlider: Codable, WAHashable {
    var id = UUID()
    
	let cat: String?
	let details: String?
	let detailsAr: String?
	let hide: String?
	let idx: String?
	let img: String?
	let link: String?
	let linkType: String?
	let title: String?
	let titleAr: String?

	enum CodingKeys: String, CodingKey {
		case cat = "cat"
		case details = "details"
		case detailsAr = "details_ar"
		case hide = "hide"
		case id = "id"
		case img = "img"
		case link = "link"
		case linkType = "link_type"
		case title = "title"
		case titleAr = "title_ar"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cat = try values.decodeIfPresent(String.self, forKey: .cat)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		detailsAr = try values.decodeIfPresent(String.self, forKey: .detailsAr)
		hide = try values.decodeIfPresent(String.self, forKey: .hide)
		idx = try values.decodeIfPresent(String.self, forKey: .id)
		img = try values.decodeIfPresent(String.self, forKey: .img)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		linkType = try values.decodeIfPresent(String.self, forKey: .linkType)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
	}
}
