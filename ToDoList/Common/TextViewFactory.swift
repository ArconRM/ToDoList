//
//  TextViewFactory.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

class TextViewFactory {
    static func buildTextView(fontSize: FontSizes, weight: UIFont.Weight = .medium, textColor: UIColor? = nil) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: fontSize.rawValue, weight: weight)
        textView.textColor = textColor
        textView.isScrollEnabled = false
        return textView
    }
}
