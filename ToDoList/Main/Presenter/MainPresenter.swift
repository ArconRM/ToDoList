//
//  MainPresenter.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    private let interactor: MainInteractorProtocol
    private let router: MainRouter
    weak var view: MainViewProtocol?
    
    init(interactor: MainInteractorProtocol, router: MainRouter) {
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
                DispatchQueue.main.async { self?.view?.loadedAllToDos(toDos) }
            case .failure(let failure):
                DispatchQueue.main.async { self?.view?.showError(failure) }
            }
        }
    }
    
    func toggleIsCompleted(for toDo: ToDo) {
        do {
            try interactor.toggleIsChecked(for: toDo)
            fetchAllToDos()
        } catch(let error) {
            view?.showError(error)
        }
    }
    
    func deleteToDo(toDo: ToDo) {
        do {
            try interactor.deleteToDo(toDo: toDo)
            fetchAllToDos()
        } catch(let error) {
            view?.showError(error)
        }
    }
    
    func showEditToDo(toDo: ToDo) {
        router.showEditToDoView(toDo: toDo)
    }
}
