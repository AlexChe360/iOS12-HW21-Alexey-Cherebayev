//
//  CardCell.swift
//  iOS12-HW21-Alexey-Cherebayev
//
//  Created by Alex on 05.04.2024.
//

import UIKit

class CardCell: UITableViewCell {
    
    public static let identifier = "CardCell"
    
    // MARK: - UI
    
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews([
            pictureImageView,
            nameLabel
        ])
        return view
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups

    private func setupHierarchy() {
        self.addSubview(mainView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            pictureImageView.widthAnchor.constraint(equalToConstant: 50),
            pictureImageView.heightAnchor.constraint(equalToConstant: 50),
            pictureImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5)
        ])
    }
    
    public func config(card: Card) {
        nameLabel.text = card.name
        if let imageUrl = card.imageUrl {
            pictureImageView.load(url: URL(string: imageUrl)!)
        }
    }

}
