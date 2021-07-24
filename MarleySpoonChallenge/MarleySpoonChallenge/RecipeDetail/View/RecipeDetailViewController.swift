//
//  RecipeDetailViewController.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 23/07/21.
//

import Foundation
import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: UI Elements
    lazy var containerView: UIView = {
        let view = UIView()
        view.setupRoundedCorners(radius: 10)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var descriptionView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.textAlignment = .left
        textView.setupRoundedCorners(radius: 14)
        return textView
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.accessibilityIdentifier = "Recipe name"
        return label
    }()
    
    lazy var chefLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.borders
        return label
    }()
    
    lazy var descriptionArea: UITextView = {
        let textView = UITextView()
        textView.font =  UIFont.systemFont(ofSize: 13)
        textView.isEditable = false
        textView.textAlignment = .left
        textView.textColor = UIColor.label
        return textView
    }()
    
    private let viewModel: RecipeDetailVieModel
    
    init(with viewModel: RecipeDetailVieModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.clearNavigationBackground()
        navigationController?.navigationBar.tintColor = UIColor.primary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setViewsContrainst()
        setUI(with: viewModel.getRecipe())
    }
    
    private func addSubviews() {
        self.view.addSubview(containerView)
        self.view.addSubview(recipeImage)
        self.view.addSubview(recipeLabel)
        self.view.addSubview(chefLabel)
        self.view.addSubview(descriptionArea)
    }
    
    private func setViewsContrainst() {
        setContainerConstraints()
        setRecipeImageConstrains()
        setRecipeLabelConstrains()
        setHeadLineLabelConstrains()
        setDescriptionTextConstrains()
    }
    
    private func setUI(with recipe: Recipe) {
        self.view.backgroundColor = UIColor.background
        recipeLabel.text = recipe.title
        chefLabel.text = recipe.chef?.name
        descriptionArea.attributedText = recipe.description.htmlToAttributedString
        setRecipeImage(with: recipe.image?.url, fileName: recipe.image?.file?.fileName ?? "")
    }
    
    private func setRecipeImage(with image: URL?, fileName: String) {
        recipeImage.loadImage(withUrl: image, fileName: fileName)
    }
}
// MARK: - Constraints
private extension RecipeDetailViewController {
    
    private func setContainerConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        containerView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setRecipeImageConstrains() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4).isActive = true
        recipeImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        recipeImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        recipeImage.setupRoundedCorners(radius: 15)
    }
    
    private func setRecipeLabelConstrains() {
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        recipeLabel.bottomAnchor.constraint(equalTo: recipeImage.topAnchor, constant: -5).isActive = true
        recipeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo:
            containerView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setHeadLineLabelConstrains() {
        chefLabel.translatesAutoresizingMaskIntoConstraints = false
        chefLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 5).isActive = true
        chefLabel.trailingAnchor.constraint(equalTo:
            containerView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setDescriptionTextConstrains() {
        descriptionArea.translatesAutoresizingMaskIntoConstraints = false
        descriptionArea.topAnchor.constraint(equalTo: chefLabel.bottomAnchor, constant: 15).isActive = true
        descriptionArea.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        descriptionArea.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        descriptionArea.trailingAnchor.constraint(equalTo:
            containerView.trailingAnchor, constant: -15).isActive = true
        descriptionArea.widthAnchor.constraint(lessThanOrEqualTo: containerView.widthAnchor, multiplier: 1).isActive = true
    }
}
