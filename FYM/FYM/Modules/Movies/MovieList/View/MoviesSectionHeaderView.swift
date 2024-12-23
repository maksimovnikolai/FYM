//
//  MoviesSectionHeaderView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 19.12.2024.
//

import UIKit
import SnapKit

final class MoviesSectionHeaderView: UICollectionReusableView {
    static let identifier = "MoviesSectionHeaderView"
    
    // MARK: - UI components
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure header title

extension MoviesSectionHeaderView {
    func setTitle(_ title: String) {
        textLabel.text = title
    }
}
