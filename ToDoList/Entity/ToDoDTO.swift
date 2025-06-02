//
//  ToDoDTO.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 01.06.2025.
//

import Foundation

//{"id":1,"todo":"Do something nice for someone you care about","completed":false,"userId":152},{"id":2,"todo":"Memorize a poem","completed":true,"userId":13},{"id":3,"todo":"Watch a classic movie","completed":true,"userId":68},{"id":4,"todo":"Watch a documentary","completed":false,"userId":84},{"id":5,"todo":"Invest in cryptocurrency","completed":false,"userId":163},{"id":6,"todo":"Contribute code or a monetary donation to an open-source software project","completed":false,"userId":69},{"id":7,"todo":"Solve a Rubik's cube","completed":true,"userId":76}

struct ToDoDTO: Codable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
}

extension ToDoDTO {
    static var mocks: [ToDoDTO] {
        return [
            .init(id: 1, todo: "Do something nice for someone you care about", completed: false, userId: 152),
            .init(id: 2, todo: "Memorize a poem", completed: true, userId: 13),
            .init(id: 3, todo: "Watch a classic movie", completed: true, userId: 68),
            .init(id: 4, todo: "Watch a documentary", completed: false, userId: 84),
            .init(id: 5, todo: "Invest in cryptocurrency", completed: false, userId: 163),
            .init(id: 6, todo: "Contribute code or a monetary donation to an open-source software project", completed: false, userId: 69),
            .init(id: 7, todo: "Solve a Rubik's cube", completed: true, userId: 76),
        ]
    }
}
