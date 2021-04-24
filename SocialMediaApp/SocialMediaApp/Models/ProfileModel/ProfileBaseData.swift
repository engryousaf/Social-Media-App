//
//  ProfileBaseData.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation
struct ProfileBaseData : Codable {
	let code : Int?
	let meta : String?
	let data : ProfileData?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case meta = "meta"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
		meta = try values.decodeIfPresent(String.self, forKey: .meta)
		data = try values.decodeIfPresent(ProfileData.self, forKey: .data)
	}

}
