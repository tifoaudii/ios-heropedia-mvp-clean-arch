//
//  HeroCell.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import UIKit
import Kingfisher

final class HeroCell: UITableViewCell {
    
    static let cellIdentifier = "HeroCellIdentifier"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        return imageView
    }()
    
    private lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var heroAttributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heroRoleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heroNameLabel, heroAttributeLabel, heroRoleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureCell() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(heroImageView)
        containerView.addSubview(stackView)
        
        
        containerView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0
        )
        
        heroImageView.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: nil,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 0,
            width: 130,
            height: 0
        )

        stackView.anchor(
            top: containerView.topAnchor,
            leading: heroImageView.trailingAnchor,
            bottom: nil,
            trailing: containerView.trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 0,
            paddingRight: 10,
            width: 0,
            height: 0
        )
    }
    
    func bindViewWith(data: Hero) {
        let imageUrl: String = DefaultNetworkDataStore.baseImageUrl + data.img
        heroImageView.kf.setImage(with: URL(string: imageUrl))
        heroNameLabel.text = data.localizedName
        heroAttributeLabel.text = "Attribute: \(data.primaryAttr.rawValue)"
        heroRoleLabel.text = "Roles: \(data.roles.map({ $0.rawValue }).joined(separator: ", "))"
    }
}
