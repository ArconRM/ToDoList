//
//  ToDoNetworkServiceProtocol.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol ToDoNetworkServiceProtocol {
    func fetchAllToDos(
        resultQueue: DispatchQueue,
        completion: @escaping (Result<[ToDoDTO], Error>) -> Void
    )
}
