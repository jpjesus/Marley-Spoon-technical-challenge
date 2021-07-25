//
//  RecipeListTests.swift
//  MarleySpoonChallengeTests
//
//  Created by Jesus Parada on 24/07/21.
//

import Foundation
import XCTest
@testable import MarleySpoonChallenge

class RecipeListTests: XCTestCase {

    private var viewModel: RecipeListProtocol?
    private var navigation: UINavigationController? = UINavigationController()
    
    override func setUp() {
        super.setUp()
        let provider: RecipeProviderProtocol =  RecipeProviderMock()
        viewModel = RecipeListViewModel(with: provider)
    }
    
    func test_getRecipes_ExpectEqualTo() {
        var recipes: [Recipe] = []
        
        let expectedCountOfRecipes = 2
        let expectedFirstRecipeName = "Harry Potter Bertie Botts flavors"
        let expectedFirstRecipeCalories = 0.0000001
        let expectedFistRecipeDesc = "Bertie Bott's Every-Flavour Beans really do come in all flavours, from chocolate to earwax and marmalade to liver"
        let expectedChefName = "Albus Dumbledore"
        let expectedTagsForFirstRecipe = 2
        
        let expectation = self.expectation(description: "fetching the recipes")
            
        viewModel?.fetchRecipes(with: navigation, completion: { recipeList in
            recipes = recipeList
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2)
        
        guard let firstRecipe = recipes.first else {
            XCTFail("Recipe list shouldnt be empty")
            return
        }
        
        XCTAssertEqual(firstRecipe.title, expectedFirstRecipeName, "Recipe title should be equal to \(expectedCountOfRecipes)")
        XCTAssertEqual(firstRecipe.description, expectedFistRecipeDesc, "Recipe description should be equal to \(expectedFistRecipeDesc)")
        XCTAssertEqual(firstRecipe.calories, expectedFirstRecipeCalories, "Recipe calories should be equal to \(expectedFirstRecipeCalories)")
        XCTAssertEqual(firstRecipe.chef?.name, expectedChefName, "Chef name should be equal to \(expectedChefName)")
        XCTAssertEqual(firstRecipe.tags.count, expectedTagsForFirstRecipe, "the tags on the recipe should be equal to \(expectedTagsForFirstRecipe)")
    }
    
    func test_viewControllerColletion_ExpectEqualTo() {
        
        guard let vm = viewModel else {
            XCTFail("view model should be nil")
            return
        }
        
        let vc = RecipeListViewController(with: vm)
        navigation?.setViewControllers([vc], animated: true)
        
        guard let collectionView: UICollectionView = Mirror(reflecting: vc)
            .descendant("recipeCollectionView") as? UICollectionView else {
                return
        }
        XCTAssertEqual(collectionView.visibleCells.count, 2)
    }
    
    override func tearDown() {
        super.tearDown()
        navigation = nil
    }
}
