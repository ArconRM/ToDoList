//
//  EditToDoPresenter.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

final class EditToDoPresenter: EditToDoPresenterProtocol {
    
    private let interactor: EditToDoInteractorProtocol
    weak var view: EditToDoViewProtocol?
    var toDo: ToDo
    
    init(interactor: EditToDoInteractorProtocol, toDo: ToDo) {
        self.interactor = interactor
        self.toDo = toDo
    }
    
    func viewDidLoad() {
        view?.configureWithItem(toDo)
    }
    
    func updateToDo(title: String?, description: String?) {
        toDo.title = title != nil && title!.count > 0 ? title! : toDo.title
        toDo.description = description != nil && description!.count > 0 ? description! : toDo.description
        
        interactor.updateToDo(toDo: toDo) { [weak self] result in
            switch result {
            case .success(let toDos):
                break
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.view?.showError(failure)
                }
            }
        }
    }
}
