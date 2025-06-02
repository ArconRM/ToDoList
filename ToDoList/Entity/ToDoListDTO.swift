//
//  ToDoListDTO.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct ToDoListDTO: Codable {
    let todos: [ToDoDTO]
    let total: Int
    let skip: Int
    let limit: Int
}
