//
//  MainPresenter.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    private let interactor: MainInteractorProtocol
    private let router: MainRouterProtocol
    weak var view: MainViewProtocol?
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
//        fetchAllToDos()
    }
    
    func fetchAllToDos() {
        interactor.fetchToDos { [weak self] result in
            switch result {
            case .success(let toDos):
                DispatchQueue.main.async {
                    self?.view?.loadedAllToDos(toDos.sorted(by: { $0.id > $1.id }))
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.view?.showError(failure)
                }
            }
        }
    }
    
    func createNewToDo() {
        interactor.createEmptyToDo { [weak self] result in
            switch result {
            case .success(let newToDo):
                DispatchQueue.main.async {
                    self?.showEditToDo(toDo: newToDo)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(error)
                }
            }
        }
    }

    func toggleIsCompleted(for toDo: ToDo) {
        interactor.toggleIsChecked(for: toDo) { [weak self] result in
            switch result {
            case .success:
                self?.fetchAllToDos()
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(error)
                }
            }
        }
    }

    func deleteToDo(toDo: ToDo) {
        interactor.deleteToDo(toDo: toDo) { [weak self] result in
            switch result {
            case .success:
                self?.fetchAllToDos()
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(error)
                }
            }
        }
    }
    
    func showEditToDo(toDo: ToDo) {
        router.showEditToDoView(toDo: toDo)
    }
}
