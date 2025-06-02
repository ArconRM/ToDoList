//
//  ToDoUrlSource.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct ToDoUrlSource: ToDoUrlSourceProtocol {
    private let baseUrlString: String = "https://dummyjson.com/"
    
    func getBaseUrl() -> URL {
        return URL(string: baseUrlString)!
    }
    
    func getAllToDosUrl() -> URL {
        return URL(string: baseUrlString)!.appendingPathComponent("todos")
    }
}
