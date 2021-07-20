//
//  Tag.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import Contentful
/**
    Class that represent a Tag for a recipe.
*/
class Tag: EntryDecodable, FieldKeysQueryable {
    
    static let contentTypeId: String = "tag"
    
    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?
    
    let name: String?
    
    public enum FieldKeys: String, CodingKey {
        case name
    }
    
    init(name: String) {
        self.name = name
        self.id = ""
        self.localeCode = "US"
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    required init(from decoder: Decoder) throws {
        let system = try decoder.sys()
        id = system.id
        localeCode = system.locale
        updatedAt = system.updatedAt
        createdAt = system.createdAt
        
        let fields = try decoder.contentfulFieldsContainer(keyedBy: Tag.FieldKeys.self)
        name = try fields.decodeIfPresent(String.self, forKey: .name)
    }
}
