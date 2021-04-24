//
//  PostComments.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//


import Foundation
struct PostComments : Codable {
	let code : Int?
	let meta : PostCommentsMeta?
	let data : [PostCommentsData]?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case meta = "meta"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
		meta = try values.decodeIfPresent(PostCommentsMeta.self, forKey: .meta)
		data = try values.decodeIfPresent([PostCommentsData].self, forKey: .data)
	}

}
