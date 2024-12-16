//
//  SettingsView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit
import SnapKit

protocol SettingsViewDelegate: AnyObject {}

final class SettingsView: UIView {
    weak var delegate: SettingsViewDelegate?
    
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

// MARK: - Constraints

private extension SettingsView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        backgroundColor = .systemBackground
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}
