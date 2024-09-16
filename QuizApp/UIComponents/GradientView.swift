//
//  GradientView.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    init(viewCornerRadius: CGFloat = 22, layerCornerRadius: CGFloat = 22, colors: [UIColor]  = [UIColor.systemRed.withAlphaComponent(0.5),UIColor.systemYellow]) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = viewCornerRadius
        gradientLayer.cornerRadius = layerCornerRadius
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
