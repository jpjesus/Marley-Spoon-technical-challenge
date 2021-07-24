//
//  RecipeDetailVieModel.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 23/07/21.
//

import Foundation

class RecipeDetailVieModel {
    
    private let recipe: Recipe
    
    init(with recipe: Recipe) {
        self.recipe = recipe
    }
    
    func getRecipe() -> Recipe {
        return recipe
    }
}
