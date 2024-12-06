//
//  LoginAndCreateAccountButtonsView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 06.12.2024.
//

import UIKit
import SnapKit

protocol LoginAndCreateAccountButtonsViewDelegate: AnyObject {
    func didTapLoginButton()
    func didTapCreateAccount()
}

final class LoginAndCreateAccountButtonsView: UIView {
    weak var delegate: LoginAndCreateAccountButtonsViewDelegate?
    
    // MARK: - UI components

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Войти"
        button.addTarget(self, action: #selector(logInButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новый пользователь?"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.title = "Создать аккаунт"
        button.configuration?.buttonSize = .small
        button.configuration?.titleAlignment = .trailing
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(createAccountButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        [titleLabel, createAccountButton].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [logInButton, horizontalStackView].forEach { stackView.addArrangedSubview($0) }
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

private extension LoginAndCreateAccountButtonsView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(buttonsStackView)
    }
    
    func setupConstraints() {
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalToSuperview()
        }
    }
    
    @objc
    func logInButtonDidTap() {
        delegate?.didTapLoginButton()
    }
    
    @objc
    func createAccountButtonDidTap() {
        delegate?.didTapCreateAccount()
    }
}
