//
//  ToDoTableViewDelegate.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

class ToDoTableViewDelegate: NSObject {
    
    weak var cellDelegate: ToDoTableViewCellDelegate?
    
    static let estimatedRowHeight: CGFloat = 170
    
    var items: [ToDo] = []
    var filteredItems: [ToDo] = []
    private var isSearching = false
    
    func setItems(items: [ToDo]) {
        self.items = items
        self.filteredItems = items
    }
    
    func filterItems(with searchText: String) {
        if searchText.isEmpty {
            filteredItems = items
            isSearching = false
        } else {
            filteredItems = items.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.description.lowercased().contains(searchText.lowercased())
            }
            isSearching = true
        }
    }
}

extension ToDoTableViewDelegate: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredItems.count
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
        
        cell.configure(item: filteredItems[indexPath.section])
        cell.backgroundColor = .clear
        cell.delegate = cellDelegate

        return cell
    }
}
