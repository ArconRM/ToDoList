//
//  ToDoUrlSourceProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol ToDoUrlSourceProtocol {
    func getBaseUrl() -> URL
    func getAllToDosUrl() -> URL
}
