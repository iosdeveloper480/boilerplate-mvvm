//
//  SliderViewModel.swift
//  FATIMA
//
//  Created by EDS on 14/07/2022.
//

import Foundation
import UIKit

protocol SliderViewModelDelegate: ViewModelDelegate {
    func didSelectItem(at indexPath: IndexPath)
}

class SliderViewModel: BaseViewModel, UICollectionViewDelegate {
    
    private lazy var initializedDataSource = makeDataSource()
    typealias DataSource = UICollectionViewDiffableDataSource<Int, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>
    private var collectionView: UICollectionView?
    
    private var example: Example?
    weak var delegate: HomeViewModelDelegate?
    
    override init(collectionView: UICollectionView?) {
        super.init(collectionView: collectionView)
        self.collectionView = collectionView
        self.collectionView?.backgroundColor = HConstants.Theme.Colors.backgroundColor
        UserNetwork().HomeExample(params: ["st":"1",
                                         "lang":"0",
                                         "version":"19",
                                         "token":"",
                                           "user_id":""]) { example in
            self.example = example
            self.apply()
        }
    }
    
    deinit {
        print("SliderViewModel deinit called")
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
            let cell = SliderCell.initialize(with: collectionView, indexPath: indexPath)
            if let sliders = self?.example?.slider {
                cell.cellDataSource(model: sliders[indexPath.item])
            }
            return cell
        })
        return dataSource
    }
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        if let sliders = self.example?.slider {
            snapshot.appendSections([0])
            snapshot.appendItems(sliders, toSection: 0)
        }
        initializedDataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func configureLayout() {
        self.collectionView!.register(cell: SliderCell.self)
        self.collectionView!.register(cell: CategoryCell.self)
        self.collectionView?.register(UINib(nibName: "SimpleTitleCVCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SimpleTitleCVCell")
        
        self.collectionView?.delegate = self
        collectionView!.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.createSingleListSection(height: 200)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
            return section
        })
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(at: indexPath)
    }
}
//extension SliderViewModel {
//    /// Creates the layout for the Featured styled sections
//    private func createSingleListSection(height: CGFloat) -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .absolute(height))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                     heightDimension: .absolute(height))
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
//                                                             subitems: [layoutItem])
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        section.orthogonalScrollingBehavior = .groupPaging
//        return section
//    }
//}
