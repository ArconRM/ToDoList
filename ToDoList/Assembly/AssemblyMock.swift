//
//  AssemblyMock.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

struct AssemblyMock: AssemblyProtocol {
    func buildMainViewController() -> MainViewController {
        let presenter = MainPresenter(
            interactor: MainInteractor(
                toDoNetworkService: ToDoNetworkServiceMock(),
                toDoPersistenceManager: ToDoCoreDataManager()
            ),
            router: MainRouter(
                navigationController: UINavigationController(),
                assembly: self
            )
        )
        
        let view = MainViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
