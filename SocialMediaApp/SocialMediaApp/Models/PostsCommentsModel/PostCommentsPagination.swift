//
//  PostCommentsPagination.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//


import Foundation
struct PostCommentsPagination : Codable {
	let total : Int?
	let pages : Int?
	let page : Int?
	let limit : Int?

	enum CodingKeys: String, CodingKey {

		case total = "total"
		case pages = "pages"
		case page = "page"
		case limit = "limit"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		pages = try values.decodeIfPresent(Int.self, forKey: .pages)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
	}

}
