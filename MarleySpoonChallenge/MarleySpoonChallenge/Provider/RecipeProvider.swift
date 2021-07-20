//
//  RecipeProvider.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import Contentful

final class RecipeProvider {
    
    private let spaceID: String = "kk2bw5ojx476"
    private let accessToken: String = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    private let recipeListID: String = "recipe"
    private let client: Client
    
    init() {
        client = Client(spaceId: spaceID,
                        accessToken: accessToken,
                        contentTypeClasses: [Recipe.self, Chef.self, Tag.self])
    }
    
    func getRecipeList(completion: @escaping (Result<HomogeneousArrayResponse<Recipe>, Error>) -> Void) {
        let query = QueryOn<Recipe>.where(contentTypeId: recipeListID)
        client.fetchArray(of: Recipe.self, matching: query) { (result: Result<HomogeneousArrayResponse<Recipe>, Error>) in
            completion(result)
        }
    }
}
