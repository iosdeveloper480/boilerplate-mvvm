//
//  CartViewModel.swift
//  FATIMA
//
//  Created by EDS on 13/07/2022.
//

import Foundation
import UIKit

protocol CartViewModelDelegate: ViewModelDelegate {
    func didTapDeleteButton(model: AnyHashable?)
}

class CartViewModel: BaseViewModel, UICollectionViewDelegate {
    
    private lazy var initializedDataSource = makeDataSource()
    typealias DataSource = UICollectionViewDiffableDataSource<Int, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>
    private var collectionView: UICollectionView?
    
    weak var delegate: CartViewModelDelegate?
    
    private var topList = [AnyHashable]()
    
    override init(collectionView: UICollectionView?) {
        super.init(collectionView: collectionView)
        self.collectionView = collectionView
        self.collectionView?.backgroundColor = HConstants.Theme.Colors.backgroundColor
        self.apply()
    }
    
    deinit {
        print("TimeSlotViewModel deinit called")
    }
    
    func apply() {
        self.configureLayout()
        self.applySnapshot()
    }
    
    func reloadData() {
        self.collectionView?.reloadData()
    }
    
    //MARK: Functions
    private func makeDataSource() -> DataSource? {
        let dataSource = DataSource(collectionView: self.collectionView!, cellProvider: {[weak self] (collectionView, indexPath, video) -> UICollectionViewCell? in
            let cell = CartCell.initialize(with: collectionView, indexPath: indexPath)
            cell.delegate = self
            return cell
        })
        return dataSource
    }
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(self.topList, toSection: 0)
        initializedDataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func configureLayout() {
        self.collectionView!.register(cell: CartCell.self)
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createSingleListSection(height: 150, layoutEnvironment: layoutEnvironment)
        })
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: SectionBackgroundView.reuseIdentifier)
        self.collectionView!.collectionViewLayout = layout
    }
}
//extension CartViewModel {
//    /// Creates the layout for the Featured styled sections
//    private func createSingleListSection(height: CGFloat,
//                                         layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
//
//        var listConfig = UICollectionLayoutListConfiguration(appearance: .plain)
//        listConfig.showsSeparators = true
//        let section = NSCollectionLayoutSection.list(using: listConfig,
//                                                     layoutEnvironment: layoutEnvironment)
//
//        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.reuseIdentifier)
//        section.decorationItems = [sectionBackground]
//
//        return section
//    }
//}

extension CartViewModel: CartCellDelegate {
    func didTapDeleteButton(model: AnyHashable?) {
        self.delegate?.didTapDeleteButton(model: model)
    }
}
