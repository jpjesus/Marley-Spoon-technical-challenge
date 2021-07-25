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
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.accessibilityIdentifier = "Recipe name"
        return label
    }()
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.text = "Tags: "
        label.isHidden = true
        return label
    }()
    
    lazy var chefLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
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
    
    // MARK: UI Elements
    lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.register(TagCellView.self,
                            forCellWithReuseIdentifier: TagCellView.identifier)
        return collection
    }()
    
    private let viewModel: RecipeDetailProtocol
    
    init(with viewModel: RecipeDetailProtocol) {
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
        setCollectionLayout()
    }
    
    private func addSubviews() {
        view.addSubview(containerView)
        view.addSubview(recipeImage)
        view.addSubview(recipeLabel)
        view.addSubview(chefLabel)
        view.addSubview(descriptionArea)
        view.addSubview(tagLabel)
        view.addSubview(tagCollectionView)
    }
    
    private func setViewsContrainst() {
        setContainerConstraints()
        setRecipeImageConstrains()
        setRecipeLabelConstrains()
        setHeadLineLabelConstrains()
        setDescriptionTextConstrains()
        setTagLabelConstrains()
        setTagCollectionConstraints()
    }
    
    private func setUI(with recipe: Recipe) {
        self.view.backgroundColor = UIColor.background
        recipeLabel.text = recipe.title
        let chefName = recipe.chef?.name ?? ""
        if !chefName.isEmpty {
            chefLabel.text = "by: " + chefName
        }
        descriptionArea.attributedText = recipe.description.htmlToAttributedString
        setRecipeImage(with: recipe.image?.url, fileName: recipe.image?.file?.fileName ?? "")
    }
    
    private func setRecipeImage(with image: URL?, fileName: String) {
        recipeImage.loadImage(withUrl: image, fileName: fileName)
    }
    
    private func setCollectionLayout() {
        let tagsCount = viewModel.getRecipe().tags.count
        if tagsCount > 0 {
            tagLabel.isHidden = false
            tagCollectionView.reloadData()
        }
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
        descriptionArea.trailingAnchor.constraint(equalTo:
                                                    containerView.trailingAnchor, constant: -15).isActive = true
        descriptionArea.heightAnchor.constraint(lessThanOrEqualTo: containerView.heightAnchor, multiplier: 1).isActive = true
        descriptionArea.widthAnchor.constraint(lessThanOrEqualTo: containerView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setTagLabelConstrains() {
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.topAnchor.constraint(equalTo: descriptionArea.bottomAnchor, constant: 2).isActive = true
        tagLabel.bottomAnchor.constraint(equalTo: tagCollectionView.topAnchor, constant: -5).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        tagLabel.widthAnchor.constraint(greaterThanOrEqualTo: containerView.widthAnchor, multiplier: 1).isActive = true
        tagLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func setTagCollectionConstraints() {
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        tagCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        tagCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        tagCollectionView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
// MARK: - Collection Flow datasource
extension RecipeDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tagsCount = viewModel.getRecipe().tags.count
        return tagsCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCellView.identifier,
                                                            for: indexPath) as? TagCellView else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.setTag(with: viewModel.getRecipe().tags[indexPath.row].name ?? "")
        cell.clipsToBounds = false
        return cell
    }
}

// MARK: - Collection Flow Layout
extension RecipeDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 20)
    }
}
