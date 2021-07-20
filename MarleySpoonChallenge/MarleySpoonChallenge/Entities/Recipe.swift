//
//  Recipe.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import Contentful
/**
    Class that represent a recipe for a meal.
*/
class Recipe: EntryDecodable, FieldKeysQueryable {
    
    static let contentTypeId: String = "recipe"
    var localeCode: String?
    var updatedAt: Date?
    var createdAt: Date?
    
    var id: String = ""
    var title: String = ""
    var calories: Int = 0
    var description: String = ""
    var image: Asset?
    var thumbnail: String = ""
    var chef: Chef?
    var tags: [Tag] = []
    
    public enum FieldKeys: String, CodingKey {
        case title
        case description
        case tags
        case chef
        case photo
        case calories
        case name
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        
        let system = try decoder.sys()
        id = system.id
        localeCode = system.locale
        updatedAt = system.updatedAt
        createdAt = system.createdAt
        
        let container = try decoder.contentfulFieldsContainer(keyedBy: Recipe.FieldKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        calories = try container.decodeIfPresent(Int.self, forKey: .calories) ?? 0
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        
        try container.resolveLink(forKey: .photo, decoder: decoder) { [weak self] photo in
            self?.image = photo as? Asset
        }
        
        try container.resolveLinksArray(forKey: .tags, decoder: decoder) { [weak self] tags in
            self?.tags = tags as? [Tag] ?? []
        }
        
        try container.resolveLink(forKey: .chef, decoder: decoder) { [weak self] parseChef in
            self?.chef = parseChef as? Chef
        }
    }
}
