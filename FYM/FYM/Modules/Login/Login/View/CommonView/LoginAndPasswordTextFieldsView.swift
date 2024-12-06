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
    
    private lazy var logTextField: UITextField = makeTextField(placeholder: "Логин", image: "person.fill")
    private lazy var passTextField: UITextField = makeTextField(placeholder: "Пароль", image: "lock.fill", isRightViewActive: true)
    
    private lazy var stackWithTextFields: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        [logTextField, passTextField].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension LoginAndPasswordTextFieldsView {
    func commonInit() {
        passTextField.delegate = self
        setupSubviews()
        setupConstraints()
        setupEyeButtonToPasswordTextField()
    }
    
    func setupSubviews() {
        addSubview(stackWithTextFields)
    }
    
    func setupConstraints() {
        [logTextField, passTextField].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(44)
                make.width.equalToSuperview()
            }
        }
        
        stackWithTextFields.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
    
    func setupEyeButtonToPasswordTextField() {
        passTextField.rightView = eyeButton
        passTextField.rightViewMode = .always
        passTextField.isSecureTextEntry = isSecureTextEntry
    }
    
    func makeTextField(placeholder: String, image: String, isRightViewActive: Bool = false) -> UITextField {
        CustomTextField(placeholder: placeholder, leftImage: image, isRightViewActive: isRightViewActive)
    }
    
    @objc
    func didTapEyeButton() {
        isSecureTextEntry.toggle()
        passTextField.isSecureTextEntry = isSecureTextEntry
        eyeButton.setImage(UIImage(systemName: eyeButtonImage), for: .normal)
    }
}

// MARK: - UITextFieldDelegate

extension LoginAndPasswordTextFieldsView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        eyeButton.isEnabled = !text.isEmpty ? true : false
    }
}
