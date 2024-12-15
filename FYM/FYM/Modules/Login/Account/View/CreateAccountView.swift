//
//  CreateAccountView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 07.12.2024.
//

import UIKit
import SnapKit

protocol AccountViewDelegate: AnyObject {
    func didTapCreateAccountButton()
}

final class CreateAccountView: UIView {
    weak var delegate: AccountViewDelegate?
    
    // MARK: - UI components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.createAccountLabelTitle
        label.font = .boldSystemFont(ofSize: Constant.titleLabelFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField = makeTextField(
        placeholder: Constant.nameTextFiledTitle,
        image: Constant.nameTextFiledImage
    )
    private lazy var emailTextField = makeTextField(
        placeholder: Constant.emailTextFieldTitle,
        image: Constant.emailTextFieldImage
    )
    private lazy var passwordTextField = makeTextField(
        placeholder: Constant.passwordTextFieldTitle,
        image: Constant.passwordTextFieldImage,
        isRightViewActive: true
    )
    private lazy var confirmPasswordTextField = makeTextField(
        placeholder: Constant.confirmPasswordTextField,
        image: Constant.confirmPasswordTextFieldImage,
        isRightViewActive: true
    )
    
    private lazy var stackViewWithTextFields: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        [
            nameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.spacing = Constant.stackViewWithTextFieldsSpacing
        return stackView
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = Constant.createAccountButtonTitle
        button.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        return button
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

// MARK: - UITextFieldDelegate

extension CreateAccountView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField.rightView != nil else { return }
        guard let text = textField.text else { return }
        textField.rightView?.isHidden = text.isEmpty ? true : false
    }
}

// MARK: - Private methods

private extension CreateAccountView {
    func commonInit() {
        backgroundColor = #colorLiteral(red: 0.9648686051, green: 0.6854533553, blue: 0.4176638722, alpha: 1)
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(stackViewWithTextFields)
        addSubview(createAccountButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constant.titleLabelTopOffset)
            make.horizontalEdges.equalToSuperview().inset(
                Constant.titleLabelHorizontalEdgesInset
            )
        }
        
        stackViewWithTextFields.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(
                Constant.stackViewWithTextFieldsHorizontalEdgesInset
            )
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(Constant.createAccountButtonHeight)
            make.horizontalEdges.equalToSuperview().inset(
                Constant.createAccountButtonHorizontalEdgesInset
            )
            make.bottom.equalToSuperview().inset(Constant.createAccountBottomInset)
        }
    }
    
    func makeTextField(placeholder: String, image: String, isRightViewActive: Bool = false) -> UITextField {
        let tf = CustomTextField(placeholder: placeholder, leftImage: image, isRightViewActive: isRightViewActive)
        return tf
    }
    
    @objc
    func didTapCreateAccountButton() {
        delegate?.didTapCreateAccountButton()
    }
}

// MARK: - Constants

private extension CreateAccountView {
    enum Constant {
        static let createAccountLabelTitle = "Создать аккаунт"
        static let titleLabelFontSize: CGFloat = 32
        static let nameTextFiledTitle = "Имя пользователя"
        static let nameTextFiledImage = "person.fill"
        static let emailTextFieldTitle = "Почта"
        static let emailTextFieldImage = "envelope.fill"
        static let passwordTextFieldTitle = "Пароль"
        static let passwordTextFieldImage = "lock.fill"
        static let confirmPasswordTextField = "Подтвердите пароль"
        static let confirmPasswordTextFieldImage = "lock.fill"
        static let createAccountButtonTitle = "Создать аккаунт"
        static let titleLabelTopOffset = 130
        static let titleLabelHorizontalEdgesInset = 32
        static let stackViewWithTextFieldsSpacing: CGFloat = 10
        static let stackViewWithTextFieldsHorizontalEdgesInset = 32
        static let createAccountButtonHeight = 44
        static let createAccountButtonHorizontalEdgesInset = 32
        static let createAccountBottomInset = 64
    }
}
