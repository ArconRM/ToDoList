//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

class ToDoTableViewCell: UITableViewCell {
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        labelsVStack.addArrangedSubview(titleLabel)
        labelsVStack.addArrangedSubview(descriptionLabel)
        labelsVStack.addArrangedSubview(dateLabel)
        
        contentView.addSubview(labelsVStack)
        contentView.addSubview(isCheckedButton)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            isCheckedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            isCheckedButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            isCheckedButton.widthAnchor.constraint(equalToConstant: 30),
            isCheckedButton.heightAnchor.constraint(equalToConstant: 30),
            
            labelsVStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelsVStack.leadingAnchor.constraint(equalTo: isCheckedButton.trailingAnchor),
            labelsVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsVStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = LabelFactory.makeLabel(fontSize: .small)
    private let descriptionLabel: UILabel = LabelFactory.makeLabel(fontSize: .small)
    private let dateLabel: UILabel = LabelFactory.makeLabel(fontSize: .small, textColor: .systemGray)
    
    private let labelsVStack: UIStackView = {
        let stackView = UIStackView()

        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.alignment = .leading

        return stackView
    }()
    
    private let isCheckedButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "circle", withConfiguration: config)
        button.setImage(image, for: .normal)

        button.tintColor = .systemGray
        return button
    }()
    
    // MARK: - Data Methods
    func configure(item: ToDo) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        dateLabel.text = item.dateCreated.description
        
        if item.isCompleted {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
            let image = UIImage(systemName: "checkmark.circle", withConfiguration: config)
            isCheckedButton.setImage(image, for: .normal)
            isCheckedButton.tintColor = .systemYellow
        }
    }
}
