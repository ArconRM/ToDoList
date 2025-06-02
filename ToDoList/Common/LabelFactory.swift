//
//  LabelFactory.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

class LabelFactory {
    static func makeLabel(fontSize: FontSizes, weight: UIFont.Weight = .medium, textColor: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: fontSize.rawValue, weight: weight)
        label.textColor = textColor
        return label
    }
}
