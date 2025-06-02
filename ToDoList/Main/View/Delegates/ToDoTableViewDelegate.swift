//
//  ToDoTableViewDelegate.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

class ToDoTableViewDelegate: NSObject {
    
    static let estimatedRowHeight: CGFloat = 170
    
    var items: [ToDo] = []
//    weak var selectionDelegate: UITableViewSelectionDelegate?
    
    func setItems(items: [ToDo]) {
        self.items = items
    }
}

extension ToDoTableViewDelegate: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ToDoTableViewDelegate.estimatedRowHeight
    }
}

extension ToDoTableViewDelegate: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.toDoCell.rawValue, for: indexPath) as! ToDoTableViewCell
        
        cell.configure(item: items[indexPath.section])
        cell.backgroundColor = .clear

        return cell
    }
}
