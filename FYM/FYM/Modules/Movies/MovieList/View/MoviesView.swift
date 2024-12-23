//
//  MoviesView.swift
//  FYM
//
//  Created by Nikolai Maksimov on 19.12.2024.
//

import UIKit
import SnapKit

protocol MoviesViewDelegate: AnyObject {}

final class MoviesView: UIView {
    weak var delegate: MoviesViewDelegate?
    
    // MARK: - Private propersties
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    private var dataSource: DataSource!
    // TODO: перенастроить секции и хедары после того как будет добавлен сетевой слой
    private enum Section: CaseIterable {
        case top10
        case top25
        case top50
        
        var header: String {
            switch self {
            case .top10:
                "Top 10"
            case .top25:
                "Top 25"
            case .top50:
                "Top 50"
            }
        }
    }
    
    // MARK: - UI components
    
    private lazy var moviesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.moviesCollectionViewCellIdentifier)
        collectionView.register(
            MoviesSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MoviesSectionHeaderView.identifier
        )
        return collectionView
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

private extension MoviesView {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.35)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(
            collectionView: moviesCollectionView, cellProvider: {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constant.moviesCollectionViewCellIdentifier,
                for: indexPath
            )
            cell.backgroundColor = .red
            return cell
        })

        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: MoviesSectionHeaderView.identifier,
                for: indexPath
            ) as? MoviesSectionHeaderView else {
                return UICollectionReusableView()
            }
            let header = Section.allCases[indexPath.section].header
            headerView.setTitle(header)
            return headerView
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.top10, .top25, .top50])
        snapshot.appendItems(Array(0..<20), toSection: .top10)
        snapshot.appendItems(Array(20..<40), toSection: .top25)
        snapshot.appendItems(Array(40..<60), toSection: .top50)
        dataSource.apply(snapshot)
    }
}

// MARK: - Constraints

private extension MoviesView {
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        configureDataSource()
    }
    
    func setupSubviews() {
        addSubview(moviesCollectionView)
    }
    
    func setupConstraints() {
        moviesCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}

// MARK: - Constants

private extension MoviesView {
    enum Constant {
        static let moviesCollectionViewCellIdentifier = "moviesCollectionViewCell"
    }
}
