//
//  MainRouter.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

struct MainRouter {
    weak var view: MainViewProtocol?
    private weak var navigationController: UINavigationController?
    private let assembly: AssemblyProtocol
    
    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func showEditToDoView(toDo: ToDo) {
        
    }
}
