//
//  RecipeListViewModel.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import Contentful
import UIKit

class RecipeListViewModel {
    
    let provider: RecipeProvider
    
    init(with provider: RecipeProvider) {
        self.provider = provider
    }
    
    func fetchRecipes(with navigation: UINavigationController?, completion: @escaping (([Recipe]) -> Void)) {
        provider.getRecipeList { result in
            switch result {
            case .success(let response):
                completion(response.items)
            case .failure(let error):
                return
            }
        }
    }
}
