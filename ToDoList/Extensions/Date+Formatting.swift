//
//  Date+Formatting.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 04.06.2025.
//

import Foundation

extension Date {
    func customFormatted(format: String = "dd/MM/yy") -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
