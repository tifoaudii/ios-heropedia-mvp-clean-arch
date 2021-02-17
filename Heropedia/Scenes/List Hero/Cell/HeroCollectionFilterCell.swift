//
//  HeroCollectionFilterCell.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import UIKit

final class HeroCollectionFilterCell: UICollectionViewCell {
    
    static let identifier = "HeroCollectionFilterCellIdentifier"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setActive() : setInActive()
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
        
    private func setupView() {
        contentView.addSubview(title)
        title.anchor(
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
        
        contentView.layoutIfNeeded()
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        setInActive()
    }
    
    private func setActive() {
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0.6470588235, blue: 1, alpha: 1)
        contentView.layer.borderColor = UIColor.clear.cgColor
        title.textColor = .white
    }
    
    private func setInActive() {
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.layer.borderColor = #colorLiteral(red: 0.790253818, green: 0.8245275617, blue: 0.8506560922, alpha: 1).cgColor
        title.textColor = #colorLiteral(red: 0.3316960931, green: 0.3553381562, blue: 0.4121007025, alpha: 1)
    }
    
    func renderViewBy(role: Role) {
        title.text = role.rawValue
    }
}
