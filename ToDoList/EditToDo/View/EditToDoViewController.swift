//
//  EditToDoViewController.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

class EditToDoViewController: UIViewController, EditToDoViewProtocol {
    
    private let presenter: EditToDoPresenterProtocol
    
    private var titleTextViewHeightConstraint: NSLayoutConstraint!
    private var descriptionTextViewHeightConstraint: NSLayoutConstraint!
    
    init(presenter: EditToDoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.updateToDo(title: titleTextView.text, description: descriptionTextView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.addSubview(titleTextView)
        view.addSubview(dateLabel)
        view.addSubview(descriptionTextView)
        
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleTextViewHeightConstraint = titleTextView.heightAnchor.constraint(equalToConstant: 40)
        descriptionTextViewHeightConstraint = descriptionTextView.heightAnchor.constraint(equalToConstant: 80)
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextViewHeightConstraint,
            
            dateLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            descriptionTextViewHeightConstraint
        ])
    }
    
    // MARK: - UI Elements
    private let titleTextView = TextViewFactory.buildTextView(fontSize: .large, weight: .bold)
    private let dateLabel = LabelFactory.makeLabel(fontSize: .small, textColor: .systemGray)
    private let descriptionTextView = TextViewFactory.buildTextView(fontSize: .medium, weight: .regular)
    
    // MARK: - Data Methods
    func configureWithItem(_ item: ToDo) {
        titleTextView.text = item.title
        dateLabel.text = item.dateCreated.description
        descriptionTextView.text = item.description
        
        updateTextViewHeight(titleTextView, heightConstraint: titleTextViewHeightConstraint)
        updateTextViewHeight(descriptionTextView, heightConstraint: descriptionTextViewHeightConstraint)
    }
}

extension EditToDoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == titleTextView {
            updateTextViewHeight(titleTextView, heightConstraint: titleTextViewHeightConstraint)
        } else if textView == descriptionTextView {
            updateTextViewHeight(descriptionTextView, heightConstraint: descriptionTextViewHeightConstraint)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            
//            presenter.updateToDo(title: titleTextView.text, description: descriptionTextView.text)
            
            return false
        }
        return true
    }
    
    private func updateTextViewHeight(_ textView: UITextView, heightConstraint: NSLayoutConstraint) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude))
        
        let minHeight: CGFloat = 60
        let calculatedHeight = max(newSize.height, minHeight)
        
        if abs(heightConstraint.constant - calculatedHeight) > 1 {
            heightConstraint.constant = calculatedHeight
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let assembly = AssemblyMock()
    let view = assembly.buildEditToDoViewController(toDo: ToDo(dto: ToDoDTO.mocks.first!))
    return view
}
