//
//  RecipeDetailTest.swift
//  MarleySpoonChallengeTests
//
//  Created by Jesus Parada on 24/07/21.
//

import Foundation
import XCTest
@testable import MarleySpoonChallenge

class RecipeDetailTest: XCTestCase {
    
    private var viewModel: RecipeDetailProtocol?
    
    
    func test_getRecipe_ExpectEqualTo() {
        
        let expectedFirstRecipeName = "Harry Potter Butterbeer"
        let expectedFirstRecipeCalories = 100.1002
        let expectedFistRecipeDesc = "A little bit like less-sickly butterscotch"
        let expectedChefName = "Romina RavenClaw"
        let expectedTagsForFirstRecipe = 1
        
        let mock = RecipeProviderMock()
        
        guard let recipe = mock.getMockedRecipes().last else {
            XCTFail("recipe shouldnt be nil")
            return
        }
        
        XCTAssertEqual(recipe.title, expectedFirstRecipeName, "Recipe title should be equal to \(expectedFirstRecipeName)")
        XCTAssertEqual(recipe.description, expectedFistRecipeDesc, "Recipe description should be equal to \(expectedFistRecipeDesc)")
        XCTAssertEqual(recipe.calories, expectedFirstRecipeCalories, "Recipe calories should be equal to \(expectedFirstRecipeCalories)")
        XCTAssertEqual(recipe.chef?.name, expectedChefName, "Chef name should be equal to \(expectedChefName)")
        XCTAssertEqual(recipe.tags.count, expectedTagsForFirstRecipe, "the tags on the recipe should be equal to \(expectedTagsForFirstRecipe)")
    }
}
