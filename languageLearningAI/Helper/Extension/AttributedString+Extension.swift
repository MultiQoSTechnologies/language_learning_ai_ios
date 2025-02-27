//
//  AttributedString+Extension.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit

extension NSAttributedString {
    /// Initialize an attributed string from Markdown and set a custom font.
    convenience init(markdown: String, font: UIFont) {
        if let data = markdown.data(using: .utf8) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            if let mutableAttributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
                // Apply the custom font to the entire range
                let fullRange = NSRange(location: 0, length: mutableAttributedString.length)
                mutableAttributedString.addAttribute(.font, value: font, range: fullRange)
                self.init(attributedString: mutableAttributedString)
                return
            }
        }
        // Fallback to plain text with the custom font.
        self.init(string: markdown, attributes: [.font: font])
    }
}
