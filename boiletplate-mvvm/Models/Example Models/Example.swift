//
//	Example.swift
//

import Foundation
protocol WAHashable: Hashable {
    var id: UUID { get set }
}
struct Example: Codable, WAHashable {
    var id = UUID()
    
    let slider: [ExSlider]?
    let slider2: [ExSlider]?
    let slider3: [ExSlider]?
    let slider4: [ExSlider]?
    let slider5: [ExSlider]?
    let slider6: [ExSlider]?
    let slider7: [ExSlider]?
    let slider8: [ExSlider]?
    let slider9: [ExSlider]?
    
    let ads: [ExAd]?
    
    let categories: [ExCategory]?
    let categories2: [ExCategory]?
    let categories3: [ExCategory]?
    let categories4: [ExCategory]?
    let categories5: [ExCategory]?
    let categories6: [ExCategory]?
    let categories7: [ExCategory]?
    let categories8: [ExCategory]?
    let categories9: [ExCategory]?
    
    let newField: [ExNew]?
    let newField2: [ExNew]?
    let newField3: [ExNew]?
    let newField4: [ExNew]?
    let newField5: [ExNew]?
    let newField6: [ExNew]?
    let newField7: [ExNew]?
    let newField8: [ExNew]?
    let newField9: [ExNew]?
    
	let version: [ExVersion]?

	enum CodingKeys: String, CodingKey {
		case ads = "ads"
		case categories = "categories"
		case newField = "new"
		case slider = "slider"
		case version = "version"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
        slider = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider2 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider3 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider4 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider5 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider6 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider7 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider8 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        slider9 = try values.decodeIfPresent([ExSlider].self, forKey: .slider)
        
        ads = try values.decodeIfPresent([ExAd].self, forKey: .ads)
        
        categories = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories2 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories3 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories4 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories5 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories6 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories7 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories8 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        categories9 = try values.decodeIfPresent([ExCategory].self, forKey: .categories)
        
        newField = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField2 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField3 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField4 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField5 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField6 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField7 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField8 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        newField9 = try values.decodeIfPresent([ExNew].self, forKey: .newField)
        
		version = try values.decodeIfPresent([ExVersion].self, forKey: .version)
	}
}
