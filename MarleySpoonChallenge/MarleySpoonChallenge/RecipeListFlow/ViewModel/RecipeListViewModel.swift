//
//  RecipeListViewModel.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import Contentful
import UIKit

class RecipeListViewModel: RecipeListProtocol {
    // MARK: UI Elements
    private let provider: RecipeProviderProtocol
    var recipes: [Recipe] = []
    
    init(with provider: RecipeProviderProtocol) {
        self.provider = provider
    }
    
    func fetchRecipes(with navigation: UINavigationController?, completion: @escaping (([Recipe]) -> Void)) {
        provider.getRecipeList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    UIViewController.showErrorAlert(with: navigation,
                                                    message: error.localizedDescription)
                }
            }
        }
    }
    
    func showRecipeDetail(with recipe: Recipe, navigation: UINavigationController?) {
        let viewModel = RecipeDetailViewModel(with: recipe)
        let vc = RecipeDetailViewController(with: viewModel)
        navigation?.modalTransitionStyle = .coverVertical
        navigation?.modalPresentationStyle = .fullScreen
        navigation?.pushViewController(vc, animated: true)
    }
}
