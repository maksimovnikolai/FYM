//
//  CustomTextField.swift
//  FYM
//
//  Created by Nikolai Maksimov on 04.12.2024.
//

import UIKit
import SnapKit

final class CustomTextField: UITextField {
    // MARK: - Private properties
    
    private let isRightViewActive: Bool
    private lazy var padding = UIEdgeInsets(
        top: 0,
        left: 30,
        bottom: 0,
        right: isRightViewActive ? 50 : 10
    )
    
    // MARK: - Init
    
    init(placeholder: String, leftImage: String, isRightViewActive: Bool = false) {
        self.isRightViewActive = isRightViewActive
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder, leftImage: leftImage)
        setupDefaultHeight()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            makeUnderline()
    }
    
    // отвечает за размещение текста внесенного пользователем
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    // отвечает за размещение placeHolder'a
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    // отвечает за размещение отредактированного текста
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupDefaultHeight() {
        self.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    private func setupTextField(placeholder: String, leftImage: String) {
        self.placeholder = placeholder
        font = .boldSystemFont(ofSize: 18)
        leftViewMode = .always
        let leftImageView = UIImageView(image: UIImage(systemName: leftImage))
        leftView = leftImageView
    }
    
    private func makeUnderline() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 1)
        layer.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(layer)
    }
}
