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
    
    // MARK: - UI components
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.image = UIImage(systemName:
                                                isSecureTextEntry
                                              ? Constant.eyeSlashImage
                                              : Constant.eyeImage)
        button.addTarget(self, action: #selector(didTapEyeButton), for: .touchUpInside)
        button.isHidden = isRightViewActive ? true : false
        return button
    }()
    
    // MARK: - Init
    
    init(placeholder: String, leftView: String, isRightViewActive: Bool = false) {
        self.isRightViewActive = isRightViewActive
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder, leftView: leftView)
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
        bounds.inset(by: setupPadding())
    }
    
    // отвечает за размещение placeHolder'a
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: setupPadding())
    }
    
    // отвечает за размещение отредактированного текста
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: setupPadding())
    }
}

// MARK: - Private methods

private extension CustomTextField {
    @objc
    func didTapEyeButton() {
        isSecureTextEntry.toggle()
        eyeButton.setImage(UIImage(systemName:
                                    isSecureTextEntry
                                   ? Constant.eyeSlashImage
                                   : Constant.eyeImage),
                           for: .normal
        )
    }
    
    func setupDefaultHeight() {
        self.snp.makeConstraints { make in
            make.height.equalTo(Constant.textFieldHeightForDefault)
        }
    }
    
    func setupTextField(placeholder: String, leftView: String) {
        self.placeholder = placeholder
        font = .boldSystemFont(ofSize: Constant.textFontSize)
        leftViewMode = .always
        self.leftView = UIImageView(image: UIImage(systemName: leftView))
        if isRightViewActive {
            isSecureTextEntry = true
            rightViewMode = .always
            rightView = eyeButton
        }
    }
    
    func makeUnderline() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 1)
        layer.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(layer)
    }
    
    func setupPadding() -> UIEdgeInsets {
        isRightViewActive
        ? Constant.paddingWithRightView
        : Constant.paddingWithoutRightView
    }
}

// MARK: - Constant

private extension CustomTextField {
    enum Constant {
        static let textFieldHeightForDefault = 44
        static let textFontSize: CGFloat = 18
        static let eyeImage = "eye"
        static let eyeSlashImage = "eye.slash"
        static let paddingWithoutRightView = UIEdgeInsets(
            top: 0,
            left: 30,
            bottom: 0,
            right: 10
        )
        static let paddingWithRightView = UIEdgeInsets(
            top: 0,
            left: 30,
            bottom: 0,
            right: 50
        )
    }
}
