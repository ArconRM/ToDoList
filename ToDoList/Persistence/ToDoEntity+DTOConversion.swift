//
//  ToDoEntity+DTOConversion.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import CoreData

extension ToDoEntity {
    static func fromDomain (_ toDo: ToDo, context: NSManagedObjectContext) -> ToDoEntity {
        let toDoEntity = ToDoEntity(context: context)
        toDoEntity.id = Int64(toDo.id)
        toDoEntity.title = toDo.title
        toDoEntity.toDoDescription = toDo.description
        toDoEntity.isCompleted = toDo.isCompleted
        toDoEntity.userId = Int64(toDo.userId)
        toDoEntity.dateCreated = toDo.dateCreated
        
        return toDoEntity
    }
    
    func toDomain() -> ToDo {
        return ToDo(
            id: Int(id),
            title: title ?? "",
            description: toDoDescription ?? "",
            isCompleted: isCompleted,
            userId: Int(userId),
            dateCreated: dateCreated ?? Date()
        )
    }
}
