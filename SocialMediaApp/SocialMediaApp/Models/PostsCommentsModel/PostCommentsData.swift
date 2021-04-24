//
//  PostCommentsData.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation
struct PostCommentsData : Codable {
	let id : Int?
	let post_id : Int?
	let name : String?
	let email : String?
	let body : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case post_id = "post_id"
		case name = "name"
		case email = "email"
		case body = "body"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		body = try values.decodeIfPresent(String.self, forKey: .body)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
