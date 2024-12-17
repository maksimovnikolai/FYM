//
//  SettingsView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 16.12.2024.
//

import UIKit
import SnapKit

protocol SettingsViewDelegate: AnyObject {
    func didSelectLogOutRow()
}

final class SettingsView: UIView {
    weak var delegate: SettingsViewDelegate?
    var alertAction: (() -> Void)?
    
    // MARK: - Private properties
    
    private var tableViewRowItems = Constant.tableViewRowItems
    
    // MARK: - UI components
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        return tableView
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

// MARK: - UITableViewDataSource

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewRowItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath)
        let item = tableViewRowItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.image = UIImage(systemName: item.image)
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - Private methods

private extension SettingsView {
    func didSelectRowAt(index: Int) {
        switch tableViewRowItems[index].type {
        case .userConfiguration:
            break
        case .account:
            break
        case .theme:
            break
        case .logOut:
            delegate?.didSelectLogOutRow()
        case .appVersion:
            alertAction?()
        }
    }
}

// MARK: - Constraints

private extension SettingsView {
    func commonInit() {
        backgroundColor = .systemBackground
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(settingsTableView)
    }
    
    func setupConstraints() {
        settingsTableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}

// MARK: - Constants

private extension SettingsView {
    enum Constant {
        static let cellIdentifier = "settigsCell"
        static let tableViewRowItems: [SettingItemViewModel] = [
            SettingItemViewModel(title: "Конфигурация пользователя", image: "person", type: .userConfiguration),
            SettingItemViewModel(title: "Учетная запись", image: "archivebox.circle", type: .account),
            SettingItemViewModel(title: "Тема", image: "paintbrush", type: .theme),
            SettingItemViewModel(title: "Выход", image: "door.left.hand.open", type: .logOut),
            SettingItemViewModel(title: "Версия приложения", image: "apps.iphone", type: .appVersion),
        ]
    }
}
