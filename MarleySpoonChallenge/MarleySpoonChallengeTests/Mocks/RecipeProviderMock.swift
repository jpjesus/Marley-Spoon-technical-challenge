//
//  RecipeProviderMock.swift
//  MarleySpoonChallengeTests
//
//  Created by Jesus Parada on 24/07/21.
//

import Foundation
import Contentful
@testable import MarleySpoonChallenge

class RecipeProviderMock: RecipeProviderProtocol {
    
    func getRecipeList(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        completion(.success(getMockedRecipes()))
    }
    
    func getMockedRecipes() -> [Recipe] {
        var recipes: [Recipe] = []
        
        let recipe1 = Recipe()
        recipe1.title = "Harry Potter Bertie Botts flavors"
        recipe1.calories = 0.0000001
        recipe1.description = "Bertie Bott's Every-Flavour Beans really do come in all flavours, from chocolate to earwax and marmalade to liver"
        recipe1.chef = Chef(name: "Albus Dumbledore")
        recipe1.tags = [Tag(name: "magic"), Tag(name: "snack")]
        
        recipes.append(recipe1)
        
        let recipe2 = Recipe()
        recipe2.title = "Harry Potter Butterbeer"
        recipe2.calories = 100.1002
        recipe2.description = "A little bit like less-sickly butterscotch"
        recipe2.chef = Chef(name: "Romina RavenClaw")
        recipe2.tags = [Tag(name: "licor")]
        
        recipes.append(recipe2)
        
        return recipes
    }
}

