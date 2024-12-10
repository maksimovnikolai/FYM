//
//  LoginAndPasswordTextFieldsView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 06.12.2024.
//

import UIKit
import SnapKit

protocol LoginAndPasswordTextFieldsViewDelegate: AnyObject {}

final class LoginAndPasswordTextFieldsView: UIView {
    weak var delegate: LoginAndPasswordTextFieldsViewDelegate?
    
    // MARK: - Private properties
    
    private var isSecureTextEntry = true
    private var eyeButtonImage: String {
        isSecureTextEntry ? "eye.slash" : "eye"
    }
    
    // MARK: - UI components
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.image = UIImage(systemName: eyeButtonImage)
        button.addTarget(self, action: #selector(didTapEyeButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var loginTextField: UITextField = makeTextField(placeholder: "Логин", image: "person.fill")
    private lazy var passwordTextField: UITextField = makeTextField(placeholder: "Пароль", image: "lock.fill", isRightViewActive: true)
    
    private lazy var stackWithTextFields: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        [loginTextField, passwordTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension LoginAndPasswordTextFieldsView {
    func commonInit() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        setupSubviews()
        setupConstraints()
        configureLoginTextField()
        configurePasswordTextField()
    }
    
    func setupSubviews() {
        addSubview(stackWithTextFields)
    }
    
    func setupConstraints() {
        [loginTextField, passwordTextField].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(44)
                make.width.equalToSuperview()
            }
        }
        
        stackWithTextFields.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
    
    func configureLoginTextField() {
        loginTextField.keyboardType = .default
        loginTextField.returnKeyType = .next
    }
    
    func configurePasswordTextField() {
        passwordTextField.rightView = eyeButton
        passwordTextField.keyboardType = .default
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        passwordTextField.returnKeyType = .done
    }
    
    func makeTextField(placeholder: String, image: String, isRightViewActive: Bool = false) -> UITextField {
        CustomTextField(placeholder: placeholder, leftImage: image, isRightViewActive: isRightViewActive)
    }
    
    @objc
    func didTapEyeButton() {
        isSecureTextEntry.toggle()
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        eyeButton.setImage(UIImage(systemName: eyeButtonImage), for: .normal)
    }
}

// MARK: - UITextFieldDelegate

extension LoginAndPasswordTextFieldsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        eyeButton.isEnabled = !text.isEmpty ? true : false
    }
}
