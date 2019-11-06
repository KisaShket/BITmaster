//
//  GitResponse.swift
//  BIT
//
//  Created by Miska  on 06/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import Foundation

struct GitResponse:Decodable {
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [Repos]?
}

struct Repos:Decodable {
    var full_name: String?
    var stargazers_count: Int?
}


