//
//  GreetingLabelsView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 06.12.2024.
//

import UIKit
import SnapKit

final class GreetingLabelsView: UIView {
    // MARK: - UI components
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет!"
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var greetingSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизуйтесь или создайте аккаунт"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackWithLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        [greetingLabel, greetingSubtitleLabel].forEach { stackView.addArrangedSubview($0) }
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

private extension GreetingLabelsView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(stackWithLabels)
    }
    
    func setupConstraints() {
        stackWithLabels.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}
