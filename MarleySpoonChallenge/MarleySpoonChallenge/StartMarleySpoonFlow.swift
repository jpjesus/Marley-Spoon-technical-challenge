//
//  StartMarleySpoonFlow.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import UIKit

final class StartMarleySpoonFlow {
    
    var navigationController: UINavigationController?
    private let provider =  RecipeProvider()
    
    init(with window: UIWindow) {
        let viewModel = RecipeListViewModel(with: provider)
        let vc = RecipeListViewController(with: viewModel)
        navigationController =  UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
