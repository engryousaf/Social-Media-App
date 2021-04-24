//
//  PostsMeta.swift
//  PaginationDemo
//
//  Created by Muhammad Yousaf on 23/04/2021.
//

import Foundation
struct PostsMeta : Codable {
	let pagination : PostsPagination?

	enum CodingKeys: String, CodingKey {

		case pagination = "pagination"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pagination = try values.decodeIfPresent(PostsPagination.self, forKey: .pagination)
	}

}
