//
//  ErrorStateCell.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 16/02/21.
//

import UIKit

class ErrorStateCell: UITableViewCell {
    
    static let identifier = "ErrorStateCellIdentifier"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "Something went wrong..."
        label.textAlignment = .center
        return label
    }()
    
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkGray
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "We are working on fixing the problem. Please try again"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(self.buttonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, desc, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    var reload: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureCell() {
        selectionStyle = .none
        contentView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
    }
    
    @objc private func buttonDidTap() {
        reload?()
    }
}
