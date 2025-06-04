//
//  AssemblyProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

protocol AssemblyProtocol {
    func buildMainViewController(navigationController: UINavigationController) -> MainViewController
    func buildEditToDoViewController(toDo: ToDo, listener: ToDoUpdateListener) -> EditToDoViewController
}
