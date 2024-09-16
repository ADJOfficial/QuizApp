//
//  BackButton.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit

class BackButton: UIButton {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(named: "back"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
