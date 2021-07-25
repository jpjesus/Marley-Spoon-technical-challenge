//
//  RecipeProviderProtocol.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 24/07/21.
//

import Foundation
import Contentful

protocol RecipeProviderProtocol {
    func getRecipeList(completion: @escaping (Result<[Recipe], Error>) -> Void)
}
