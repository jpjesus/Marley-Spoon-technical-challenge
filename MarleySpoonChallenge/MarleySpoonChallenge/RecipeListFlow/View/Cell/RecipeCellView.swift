//
//  RecipeCellView.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 20/07/21.
//

import Foundation
import Contentful
import UIKit

class RecipeCellView: UICollectionViewCell {
    
    lazy var cellContainerView: UIView = {
        let view = UIView()
        view.setupRoundedCorners(radius: 10)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor =  UIColor.primary
        return label
    }()
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var recipe: Recipe?
    private var imageTask: URLSessionTask?
    static var identifier = "RecipeCellView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        addSubviews()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        recipeImage.image = nil
        recipeLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(with recipe: Recipe) {
        self.recipe = recipe
        recipeLabel.text = recipe.title
        setRecipeImage(with: recipe.image?.file?.url, fileName: recipe.image?.file?.fileName ?? "")
        
    }
    
    private func setRecipeImage(with image: URL?, fileName: String) {
        imageTask = recipeImage.loadImage(withUrl: image, fileName: fileName)
    }
    
    private func addSubviews() {
        self.addSubview(cellContainerView)
        self.addSubview(recipeImage)
        self.addSubview(recipeLabel)
    }
    
    private func setConstraints() {
        setContainerConstraints()
        setRecipeImageConstrains()
        setRecipeLabelConstrains()
    }
    
    private func setContainerConstraints() {
        
        cellContainerView.translatesAutoresizingMaskIntoConstraints = false
        cellContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cellContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellContainerView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1).isActive = true
        cellContainerView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func setRecipeImageConstrains() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.topAnchor.constraint(equalTo: cellContainerView.topAnchor, constant: 5).isActive = true
        recipeImage.heightAnchor.constraint(equalTo: cellContainerView.heightAnchor, multiplier: 0.55).isActive = true
        recipeImage.widthAnchor.constraint(equalTo: cellContainerView.widthAnchor, multiplier: 0.55).isActive = true
        recipeImage.centerXAnchor.constraint(equalTo: cellContainerView.centerXAnchor).isActive = true
        recipeImage.setupRoundedCorners(radius: 15)
    }
    
    private func setRecipeLabelConstrains() {
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 5).isActive = true
        recipeLabel.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor, constant: 10).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo:
        cellContainerView.trailingAnchor, constant: -10).isActive = true
    }
}
