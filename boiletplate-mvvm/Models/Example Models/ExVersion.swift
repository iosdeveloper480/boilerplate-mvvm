//
//	ExVersion.swift
//

import Foundation

struct ExVersion: Codable, WAHashable {
    var id = UUID()
    
	let androidVersion: Int?
	let block: Int?
	let iosVersion: Int?
    
	enum CodingKeys: String, CodingKey {
		case androidVersion = "android_version"
		case block = "block"
		case iosVersion = "ios_version"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		androidVersion = try values.decodeIfPresent(Int.self, forKey: .androidVersion)
		block = try values.decodeIfPresent(Int.self, forKey: .block)
		iosVersion = try values.decodeIfPresent(Int.self, forKey: .iosVersion)
	}
}
