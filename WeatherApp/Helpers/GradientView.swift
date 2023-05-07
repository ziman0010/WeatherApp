//
//  GradientView.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit

final class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    @IBInspectable var endColor: UIColor? {
        didSet {
            updateColors()
        }
    }
    private let gradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func updateColors() {
        let defaultColor = UIColor(named: "default_black")!
        let startColor = (startColor ?? defaultColor).cgColor
        let endColor = (endColor ?? defaultColor).cgColor

        gradientLayer.colors = [startColor, endColor]
    }
    private func setupGradient(){
        self.layer.addSublayer(gradientLayer)
        let defaultColor = UIColor(named: "default_black")!
        let startColor = (startColor ?? defaultColor).cgColor
        let endColor = (endColor ?? defaultColor).cgColor

        gradientLayer.colors = [startColor, endColor]
    }
}
