//
//  RememberView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 06.12.2024.
//

import UIKit
import SnapKit

protocol RememberViewDelegate: AnyObject {
    func didTapRememberMeButton()
    func didTapForgotPasswordButton()
}

final class RememberView: UIView {
    weak var delegate: RememberViewDelegate?
    
    // MARK: - Private properties
    
    private var isRememberMeButtonSelected = false
    private var rememberMeButtonImage: String {
        isRememberMeButtonSelected
        ? "checkmark.square"
        : "square"
    }
    
    // MARK: - UI components
    
    private lazy var rememberMeButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.image = UIImage(systemName: rememberMeButtonImage)
        button.addTarget(self, action: #selector(didTapRememberMeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Запомнить меня?"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.title = "Забыли пароль?"
        button.configuration?.buttonSize = .small
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        [rememberMeButton, rememberMeLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var generalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        [firstStackView, forgotPasswordButton].forEach { stackView.addArrangedSubview($0) }
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

private extension RememberView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(generalStackView)
    }
    
    func setupConstraints() {
        rememberMeButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        generalStackView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
    
    @objc
    func didTapRememberMeButton() {
        isRememberMeButtonSelected.toggle()
        rememberMeButton.setImage(UIImage(systemName: rememberMeButtonImage), for: .normal)
        delegate?.didTapRememberMeButton()
    }
    
    @objc
    func didTapForgotPasswordButton() {
        delegate?.didTapForgotPasswordButton()
    }
}
