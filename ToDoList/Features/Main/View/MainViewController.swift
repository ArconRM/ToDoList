//
//  MainViewController.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

final class MainViewController: UIViewController, MainViewProtocol {
    
    private let presenter: MainPresenterProtocol
    private var toDoTableViewDelegate: ToDoTableViewDelegate?
    
    init(presenter: MainPresenterProtocol, toDoTableViewDelegate: ToDoTableViewDelegate) {
        self.presenter = presenter
        self.toDoTableViewDelegate = toDoTableViewDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        presenter.fetchAllToDos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        toDoTableViewDelegate?.cellDelegate = self
        
        toDoTableView.delegate = toDoTableViewDelegate
        toDoTableView.dataSource = toDoTableViewDelegate
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.toDoCell.rawValue)
        
        setupView()
        setupSearchController()
        setupToolbar()
        
        toDoTableView.contentInset.bottom = 44
        toDoTableView.scrollIndicatorInsets.bottom = 44
        
        presenter.viewDidLoad()
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        navigationItem.title = "Задачи"
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
    
    private func setupToolbar() {
        toolbarButton.addTarget(self, action: #selector(createToDoWasPressed), for: .touchUpInside)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)

        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        let labelContainer = UIView()
        labelContainer.addSubview(toolbarLabel)
        NSLayoutConstraint.activate([
            toolbarLabel.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor),
            toolbarLabel.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor)
        ])

        let labelItem = UIBarButtonItem(customView: labelContainer)
        let buttonItem = UIBarButtonItem(customView: toolbarButton)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([flexibleSpace, labelItem, flexibleSpace, buttonItem], animated: false)
    }
    
    @objc func createToDoWasPressed() {
        presenter.createNewToDo()
    }
    
    
    // MARK: - Setup View
    private func setupView() {
        view.addSubview(toDoTableView)
        
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toDoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toDoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UI Elements
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let toolbar = UIToolbar()
    private let toolbarLabel = LabelFactory.makeLabel(fontSize: .small)
    private let toolbarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: config)
        button.setImage(image, for: .normal)

        button.tintColor = .systemYellow
        return button
    }()
    
    private let toDoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = .gray

        tableView.backgroundColor = .clear

        return tableView
    }()
    
    // MARK: - Data Methods
    func loadedAllToDos(_ toDos: [ToDo]) {
        toDoTableViewDelegate?.setItems(items: toDos)
        toDoTableView.reloadData()
        toDoTableView.layoutIfNeeded()
        
        toolbarLabel.text = "\(toDos.count) задач"
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            self.toDoTableViewDelegate?.filterItems(with: searchText)
            
            let count = self.toDoTableViewDelegate?.filteredItems.count ?? 0
            
            DispatchQueue.main.async {
                self.toDoTableView.reloadData()
                self.toolbarLabel.text = "\(count) задач"
                
                UIView.animate(withDuration: 0.2) {
                    self.toDoTableView.layoutIfNeeded()
                }
            }
        }
    }
}

extension MainViewController: ToDoTableViewCellDelegate {
    func didTapEdit(on cell: ToDoTableViewCell) {
        guard let indexPath = toDoTableView.indexPath(for: cell),
              let toDo = toDoTableViewDelegate?.filteredItems[indexPath.section] else { return }
        
        presenter.showEditToDo(toDo: toDo)
    }
    
    func didTapDelete(on cell: ToDoTableViewCell) {
        let alertController = UIAlertController(
            title: "Удаление",
            message: "Вы уверены что хотите удалить задачу?",
            preferredStyle: .alert
        )
        
        let noAction = UIAlertAction(
            title: "Нет",
            style: .cancel,
            handler: nil
        )
        
        let yesAction = UIAlertAction(
            title: "Да",
            style: .destructive,
        ) { [weak self] _ in
            guard let indexPath = self?.toDoTableView.indexPath(for: cell),
                  let toDo = self?.toDoTableViewDelegate?.filteredItems[indexPath.section] else { return }
            
            self?.presenter.deleteToDo(toDo: toDo)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        present(alertController, animated: true)
    }
    
    func didToggleCheckmark(on cell: ToDoTableViewCell) {
        guard let indexPath = toDoTableView.indexPath(for: cell),
              let toDo = toDoTableViewDelegate?.filteredItems[indexPath.section] else { return }
        
        presenter.toggleIsCompleted(for: toDo)
    }
}

// MARK: - Preview
@available(iOS 17, *)
#Preview {
    let assembly = AssemblyMock()
    let view = assembly.buildMainViewController(navigationController: UINavigationController())
    return view
}

