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

    func createEmptyToDo() throws -> ToDo {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        let lastId = try context.fetch(fetchRequest).map({ $0.toDomain() }).map({ $0.id }).max() ?? 0

        let entity = ToDoEntity(context: context)
        entity.id = Int64(lastId + 1)
        entity.title = "Без названия"
        entity.toDoDescription = "Пусто"
        entity.isCompleted = false
        entity.userId = 0
        entity.dateCreated = Date()

        try context.save()

        return entity.toDomain()
    }

    func loadAllToDos() throws -> [ToDo] {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        return try context.fetch(fetchRequest).map({ $0.toDomain() })
    }

    func updateToDo(_ updatedToDo: ToDo) throws {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", updatedToDo.id)

        if let toDoEntity = try context.fetch(fetchRequest).first {
            toDoEntity.title = updatedToDo.title
            toDoEntity.toDoDescription = updatedToDo.description
            toDoEntity.isCompleted = updatedToDo.isCompleted
            toDoEntity.userId = Int64(updatedToDo.userId)
            toDoEntity.dateCreated = updatedToDo.dateCreated

            try context.save()
        }
    }

    func deleteToDo(id: Int) throws {
        let fetchRequest: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        if let toDoEntity = try context.fetch(fetchRequest).first {
            context.delete(toDoEntity)
            try context.save()
        }
    }
}
