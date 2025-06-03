//
//  AssemblyMock.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

struct AssemblyMock: AssemblyProtocol {
    func buildMainViewController(navigationController: UINavigationController) -> MainViewController {
        let presenter = MainPresenter(
            interactor: MainInteractor(
                toDoNetworkService: ToDoNetworkServiceMock(),
                toDoPersistenceManager: ToDoCoreDataManager()
            ),
            router: MainRouter(
                navigationController: navigationController,
                assembly: self
            )
        )
        
        let view = MainViewController(
            presenter: presenter,
            toDoTableViewDelegate: ToDoTableViewDelegate()
        )
        
        presenter.view = view
        
        return view
    }
    
    func buildEditToDoViewController(toDo: ToDo) -> EditToDoViewController {
        let presenter = EditToDoPresenter(
            interactor: EditToDoInteractor(
                toDoPersistenceManager: ToDoCoreDataManager()
            ),
            toDo: toDo
        )
        
        let view = EditToDoViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
