//
//  BaseLoaderViewController.swift
//  LaunchAppMVP+R+UIKit
//
//  Created by Anton Vlezko on 10.12.2021.
//

import UIKit

final class BaseLoaderViewController: UIViewController {
    let spinner = ActivityIndicator()
    
    override final func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimation()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

final class ActivityIndicator: UIView {
    
    // MARK: - Переменные.
    
    /// Индикатор ожидания.
    private let indicatorLayer = CAShapeLayer()
    
    /// Длина вырезанного сегмента индикатора в радианах. По-умолчанию значение pi / 3.
    var indicatorDistance: CGFloat = .pi / 2 {
        didSet { layoutSubviews() }
    }
    
    /// Цвет индикатора. По-умолчанию голубой.
    var indicatorColor: UIColor = UIColor.red {
        didSet { indicatorLayer.strokeColor = indicatorColor.cgColor }
    }
    
    /// Ширина индикатора. По-умолчанию 3.
    var indicatorWidth: CGFloat = 3 {
        didSet { indicatorLayer.lineWidth = indicatorWidth }
    }
    
    /// Заливка индикатора. По-умолчанию без заливки.
    var indicatorFillColor: UIColor = .clear {
        didSet { indicatorLayer.fillColor = indicatorFillColor.cgColor }
    }
    
    /// Скорость вращения индикатора в секундах. По-умолчанию одно вращение за 0.5 секунды.
    var animationVelocity: TimeInterval = 1 {
        didSet { rotateAnimation.duration = animationVelocity }
    }
    
    /// Объект анимации вращения индикатора. Устанавливает вращение от 0 до 2 * pi с бесконечным повторением.
    private let rotateAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.repeatCount = .greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false
        return animation
    }()
    
    /// Значение, указывающее вращается ли индикатор или нет. Возвращает `true` если вращается.
    private(set) var isAnimating: Bool = false
    
    // MARK: - Инициализаторы
    
    /// Стандартный инициализатор.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Стандартный инициализатор.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Метод для начально установки `MGActivityIndicator`. Добавляет индикатор к `super.layer` и устанавливает для
    /// него стандартные параметры (цвет, ширина и т.д.).
    private func commonInit() {
        layer.addSublayer(indicatorLayer)
        indicatorLayer.lineWidth = indicatorWidth
        indicatorLayer.strokeColor = indicatorColor.cgColor
        indicatorLayer.fillColor = indicatorFillColor.cgColor
        rotateAnimation.duration = animationVelocity
    }
    
    /// Переопределяем метод для определения frame индикатора ожидания, а также для установки его окружности.
    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorLayer.frame = bounds
        indicatorLayer.path = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: min(bounds.width, bounds.height) / 2,
            startAngle: -(.pi / 2) + indicatorDistance / 2,
            endAngle: (3 * .pi / 2) - indicatorDistance / 2,
            clockwise: true
        ).cgPath
    }
    
    /// Используйте этот метод для начала анимации вращения индикатора.
    func startAnimation() {
        guard !isAnimating else { return }
        isAnimating = true
        indicatorLayer.add(rotateAnimation, forKey: "rotate")
    }
    
    /// Используйте этот метод, чтобы остановить анимацию вращения индикатора.
    func stopAnimation() {
        guard isAnimating else { return }
        isAnimating = false
        indicatorLayer.removeAnimation(forKey: "rotate")
    }
}
