//
//  ToDoNetworkService.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

struct ToDoNetworkService: ToDoNetworkServiceProtocol {

    private let urlSource: ToDoUrlSourceProtocol
    private let session: URLSession

    init(urlSource: ToDoUrlSourceProtocol, session: URLSession = .shared) {
        self.urlSource = urlSource
        self.session = session
    }

    func fetchAllToDos(
        resultQueue: DispatchQueue,
        completion: @escaping (Result<[ToDoDTO], Error>) -> Void
    ) {
        session.dataTask(with: urlSource.getAllToDosUrl()) { data, _, error in
            if let error = error {
                resultQueue.async { completion(.failure(error)) }
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let toDoList = try decoder.decode(ToDoListDTO.self, from: data)
                    let todos = toDoList.todos
                    resultQueue.async { completion(.success(todos)) }
                } catch {
                    resultQueue.async { completion(.failure(error)) }
                }
            }
        }.resume()
    }
}
