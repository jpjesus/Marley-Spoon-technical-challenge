//
//  RecipeListViewController.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import UIKit

class RecipeListViewController: UIViewController {
    // MARK: UI Elements
    lazy var recipeCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.register(RecipeCellView.self,
                            forCellWithReuseIdentifier: RecipeCellView.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let viewModel: RecipeListViewModel
    
    init(with viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background
        addSubviews()
        getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addSubviews() {
        self.view.addSubview(recipeCollectionView)
        recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recipeCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        recipeCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        recipeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        recipeCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func getRecipes() {
        viewModel.fetchRecipes(with: self.navigationController) { [weak self] recipes in
            self?.viewModel.recipes = recipes
            self?.recipeCollectionView.reloadData()
        }
    }
}


// MARK: - Collection DataSource
extension RecipeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCellView.identifier,
                                                            for: indexPath) as? RecipeCellView else {
                                                                return UICollectionViewCell(frame: .zero)
        }
        cell.setCell(with: viewModel.recipes[indexPath.row])
        cell.clipsToBounds = false
        return cell
    }
}
// MARK: - Collection Flow Layout
extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
            
        case .portrait,
             .portraitUpsideDown:
            return CGSize(width: setWidhtSize(2,
                                              collectionViewLayout: collectionViewLayout,
                                              collectionView: collectionView),
                          height: self.view.bounds.height/4)
        case .landscapeLeft,
             .landscapeRight:
            return CGSize(width: setWidhtSize(3, collectionViewLayout: collectionViewLayout, collectionView: collectionView), height: self.view.bounds.height/2)
        default:
            return CGSize.zero
        }
    }
    
    private func setWidhtSize(_ numberOfCells: Int, collectionViewLayout: UICollectionViewLayout, collectionView: UICollectionView) -> CGFloat {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let spacing = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCells - 1))
        
        return (collectionView.bounds.width - spacing) / CGFloat(numberOfCells)
    }
}
