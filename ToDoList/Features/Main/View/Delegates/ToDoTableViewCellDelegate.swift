//
//  ToDoTableViewCellDelegate.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation

protocol ToDoTableViewCellDelegate: AnyObject {
    func didTapEdit(on cell: ToDoTableViewCell)
    func didTapDelete(on cell: ToDoTableViewCell)

    func didToggleCheckmark(on cell: ToDoTableViewCell)
}
