//
//  TagCellView.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 23/07/21.
//

import Foundation
import UIKit

class TagCellView: UICollectionViewCell {
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor.label
        return label
    }()
    
    static var identifier = "TagCellView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTag(with name: String) {
        tagLabel.text = name
        setupBorder(color: UIColor.label)
        self.setupRoundedCorners(radius: 10)
    }
    
    private func addSubviews() {
        self.addSubview(tagLabel)
    }
    
    private func setConstraints() {
        setTagConstraints()
    }
    
    private func setTagConstraints() {
        tagLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tagLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tagLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1).isActive = true
    }
}
