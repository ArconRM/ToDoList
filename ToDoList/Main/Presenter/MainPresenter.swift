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
        fetchNetworkToDos()
    }
    
    func fetchSavedToDos() {
        view?.showError(NSError(domain: "", code: 0))
    }
    
    func fetchNetworkToDos() {
        interactor.fetchToDos { [weak self] result in
            switch result {
            case .success(let toDos):
                
                DispatchQueue.main.async { self?.view?.loadedAllToDos(toDos) }
            case .failure(let failure):
                DispatchQueue.main.async { self?.view?.showError(failure) }
            }
        }
    }
}
