//
//  RecipeListProtocol.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 24/07/21.
//

import Foundation
import UIKit

protocol RecipeListProtocol {
    
    var recipes: [Recipe] { get set }
    
    func fetchRecipes(with navigation: UINavigationController?, completion: @escaping (([Recipe]) -> Void))
    func showRecipeDetail(with recipe: Recipe, navigation: UINavigationController?)
}
