//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

final class ToDoTableViewCell: UITableViewCell {
    
    var delegate: ToDoTableViewCellDelegate?
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        let interaction = UIContextMenuInteraction(delegate: self)
                addInteraction(interaction)
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
        
        isCheckedButton.addTarget(self, action: #selector(didTapIsChecked), for: .touchUpInside)

        setupConstraints()
    }
    
    @objc private func didTapIsChecked() {
        delegate?.didToggleCheckmark(on: self)
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
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.attributedText = nil
        titleLabel.text = nil
        descriptionLabel.attributedText = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        
        titleLabel.textColor = .label
        descriptionLabel.textColor = .label
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "circle", withConfiguration: config)
        isCheckedButton.setImage(image, for: .normal)
        isCheckedButton.tintColor = .systemGray
    }
    
    func configure(item: ToDo) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        dateLabel.text = item.dateCreated.customFormatted()
        
        if item.isCompleted {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
            let image = UIImage(systemName: "checkmark.circle", withConfiguration: config)
            isCheckedButton.setImage(image, for: .normal)
            isCheckedButton.tintColor = .systemYellow
            
            titleLabel.textColor = .systemGray
            descriptionLabel.textColor = .systemGray
            
            titleLabel.setStrikethrough(text: titleLabel.text ?? "")
        }
    }
}

extension ToDoTableViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                              configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let edit = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.didTapEdit(on: self)
            }
            
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.didTapDelete(on: self)
            }
            
            return UIMenu(title: "", children: [edit, delete])
        }
    }
}
