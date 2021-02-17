//
//  SimilarHeroView.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import UIKit
import Kingfisher

class SimilarHeroView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var hero: Hero? {
        didSet {
            guard let hero = hero else {
                return
            }
            
            bindViewWith(hero: hero)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(heroNameLabel)
        
        imageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            paddingTop: 6,
            paddingLeft: 6,
            paddingBottom: 0,
            paddingRight: 6,
            width: 0,
            height: 80.0
        )
        
        heroNameLabel.anchor(
            top: imageView.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            paddingTop: 12,
            paddingLeft: 6,
            paddingBottom: 6,
            paddingRight: 6,
            width: 0,
            height: 0
        )
    }
    
    private func bindViewWith(hero: Hero) {
        let imageUrl = DefaultNetworkDataStore.baseImageUrl + hero.img
        imageView.kf.setImage(with: URL(string: imageUrl))
        heroNameLabel.text = hero.localizedName
    }
}
