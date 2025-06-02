//
//  ToDoCoreDataManager.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import CoreData
import UIKit

struct ToDoCoreDataManager: ToDoPersistenceManagerProtocol {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveToDo(_ toDo: ToDo) throws {
        _ = ToDoEntity.fromDomain(toDo, context: context)
        try context.save()
    }
    
    func saveToDos(_ toDos: [ToDo]) throws {
        for toDo in toDos {
            _ = ToDoEntity.fromDomain(toDo, context: context)
        }
        try context.save()
    }
    
    func loadAllToDos() throws -> [ToDo] {
        return try context.fetch(ToDoEntity.fetchRequest()).map({ $0.toDomain() })
    }
}
