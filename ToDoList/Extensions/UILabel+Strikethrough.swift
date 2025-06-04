//
//  UILabel+Strikethrough.swift
//  ToDoList
//
//  Created by Artemiy MIROTVORTSEV on 02.06.2025.
//

import Foundation
import UIKit

extension UILabel {
    func setStrikethrough(text: String) {
        let attributedString = NSAttributedString(
            string: text,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        self.attributedText = attributedString
    }

    func removeStrikethrough() {
        guard let currentAttributedText = self.attributedText else {
            return
        }

        let mutableAttributedString = NSMutableAttributedString(attributedString: currentAttributedText)
        mutableAttributedString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: mutableAttributedString.length))

        self.attributedText = mutableAttributedString
    }
}
