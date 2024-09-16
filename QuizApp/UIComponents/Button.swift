//
//  Button.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit

class Button: UIButton {
    init(backgroundColor: UIColor = .systemBlue.withAlphaComponent(0.6), cornerRadius: CGFloat = 22, setTitle: String, setTitleColor: UIColor = .white) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.setTitle(setTitle, for: .normal)
        self.setTitleColor(setTitleColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
