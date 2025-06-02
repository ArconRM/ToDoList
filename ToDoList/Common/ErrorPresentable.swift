//
//  ErrorPresentable.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

protocol ErrorPresentable {
    func showError(_ error: Error)
}

extension ErrorPresentable where Self: UIViewController {
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        present(alertController, animated: true)
    }
}
