//
//  HeroDetailViewController.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import UIKit
import Kingfisher

final class HeroDetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var heroDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var similarHeroTitleSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Similar Heroes"
        return label
    }()
    
    private lazy var similarHeroStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var hero: Hero
    var similarHero: [Hero] = []
    
    init(hero: Hero, similarHero: [Hero]) {
        self.hero = hero
        self.similarHero = similarHero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeroDetailStackView()
        setupView()
        renderSimilarHero()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(heroDetailStackView)
        view.addSubview(similarHeroTitleSectionLabel)
        view.addSubview(similarHeroStackView)
        
        imageView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 0,
            paddingRight: 8,
            width: 0,
            height: 150
        )
        
        let imageUrl = DefaultNetworkDataStore.baseImageUrl + hero.img
        imageView.kf.setImage(with: URL(string: imageUrl))
        
        heroDetailStackView.anchor(
            top: imageView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            paddingBottom: 0,
            paddingRight: 12,
            width: 0,
            height: 0
        )
        
        similarHeroTitleSectionLabel.anchor(top: heroDetailStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        similarHeroStackView.anchor(top: similarHeroTitleSectionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 12, paddingLeft: 6, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
    }
    
    private func configureHeroDetailStackView() {
        HeroDetailViewKind.allCases.forEach { (viewKind: HeroDetailViewKind) in
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.numberOfLines = 0
            label.adjustsFontForContentSizeCategory = true
            
            switch viewKind {
            case .name:
                label.text = "Name: \(hero.localizedName)"
            case .attribute:
                label.text = "Attribute: \(hero.primaryAttr.rawValue)"
            case .health:
                label.text = "Health: \(hero.baseHealth)"
            case .maxAttack:
                label.text = "Max Attack: \(hero.baseAttackMax)"
            case .roles:
                label.text = "Roles: \(hero.roles.map({ $0.rawValue }).joined(separator: ", "))"
            case .speed:
                label.text = "Speed: \(hero.moveSpeed)"
            case .type:
                label.text = "Type: \(hero.attackType.rawValue)"
            }
            
            heroDetailStackView.addArrangedSubview(label)
        }
    }
    
    private func renderSimilarHero() {
        similarHero.forEach { (hero: Hero) in
            let view = SimilarHeroView()
            view.hero = hero
            
            similarHeroStackView.addArrangedSubview(view)
        }
    }
}
