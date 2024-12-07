//
//  LoginView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 02.12.2024.
//

import UIKit
import SnapKit

protocol LoginViewDelegate:
    LoginAndPasswordTextFieldsViewDelegate,
    RememberViewDelegate,
    LoginAndCreateAccountButtonsViewDelegate {}

// TODO: - доработать:
// - показ и скрытие клавиатуры ✅
// - установить кнопку Done на клавиатуре для поля ввода пароля✅
// - реализовать логику запоминания пользователя
// - реализовать логику напоминания пароля пользователя
// - реализовать логику перехода на экран создания аккаунта
// - реализовать логику перехода на главный экран при успешной авторизации
// - показать алерт при неверном вводе логина/пароля


final class LoginView: UIView {
    weak var delegate: LoginViewDelegate? {
        didSet {
            loginAndPasswordTextFieldsView.delegate = delegate
            rememberView.delegate = delegate
            loginAndCreateAccountButtonsView.delegate = delegate
        }
    }
    
    // MARK: - UI components
    
    private let greetingLabelsView = GreetingLabelsView()
    private let loginAndPasswordTextFieldsView = LoginAndPasswordTextFieldsView()
    private let rememberView = RememberView()
    private let loginAndCreateAccountButtonsView = LoginAndCreateAccountButtonsView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
}

// MARK: - Private methods

private extension LoginView {
    func commonInit() {
        backgroundColor = #colorLiteral(red: 0.9648686051, green: 0.6854533553, blue: 0.4176638722, alpha: 1)
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        [
            loginAndPasswordTextFieldsView,
            greetingLabelsView,
            rememberView,
            loginAndCreateAccountButtonsView,
        ].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        greetingLabelsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginAndPasswordTextFieldsView.snp.top).offset(-80)
        }
        
        loginAndPasswordTextFieldsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        }
        
        rememberView.snp.makeConstraints { make in
            make.top.equalTo(loginAndPasswordTextFieldsView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        loginAndCreateAccountButtonsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(35)
        }
    }
}
