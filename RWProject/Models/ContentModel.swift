//
//  ArticleModel.swift
//  RWProject
//
//  Created by Eli Mehaudy on 09/12/2020.
//

import Foundation

struct ContentModel: Codable {
    let data: [ContentData]?
}

struct ContentData: Codable {
    var id: String?
    var attributes: Attributes?
}

struct Attributes: Codable {
    let name: String?
    let description_plain_text: String?
    var released_at: String?
    let card_artwork_url: String?
}
