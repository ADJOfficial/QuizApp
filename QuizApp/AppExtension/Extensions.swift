//
//  Extension.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit
// MARK: For Text Font To Apply Different Sizes According to Req
extension UIFont {
    static func medium(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .medium)
    }
    static func regular(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .regular)
    }
    static func bold(ofSize: CGFloat = 25) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: .bold)
    }
}
// MARK: For AutoSized and WidthRatio For All Components
extension Int {
    var autoSized: CGFloat {
        let baseDiagonal: CGFloat = 980.0
        let screenDiagonal = sqrt(pow(UIScreen.main.bounds.width, 2) + pow(UIScreen.main.bounds.height, 2))
        let scale = screenDiagonal / baseDiagonal
        return CGFloat(self) * scale
    }
    var widthRatio: CGFloat {
        let baseWidth: CGFloat = 414.0
        let screenWidth = UIScreen.main.bounds.width
        let scale = screenWidth / baseWidth
        return CGFloat(self) * scale
    }
}
