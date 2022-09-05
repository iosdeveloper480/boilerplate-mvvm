//
//  HomeViewModel.swift
//  FATIMA
//
//  Created by EDS on 12/07/2022.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: ViewModelDelegate {
    func didSelectItem(at indexPath: IndexPath)
}

class HomeViewModel: BaseViewModel, UICollectionViewDelegate {
    
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
        print("HomeViewModel deinit called")
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
            if indexPath.section == 0 || indexPath.section == 6 {
                let cell = SliderCell.initialize(with: collectionView, indexPath: indexPath)
                if let sliders = self?.example?.slider {
                    cell.cellDataSource(model: sliders[indexPath.item])
                }
                return cell
            } else if indexPath.section == 1 || indexPath.section == 4 || indexPath.section == 7 {
                let cell = CategoryCell.initialize(with: collectionView, indexPath: indexPath)
                if let categories = self?.example?.categories {
                    cell.cellDataSource(item: categories[indexPath.item])
                }
                return cell
            } else if indexPath.section == 2 || indexPath.section == 5 {
//                let cell = ProductCell.initialize(with: collectionView, indexPath: indexPath)
//                if let newField = self?.example?.newField {
//                    cell.cellDataSource(newField: newField[indexPath.item])
//                }
//                return cell
            } else if indexPath.section == 3 {
                let cell = SliderCell.initialize(with: collectionView, indexPath: indexPath)
                if let sliders = self?.example?.slider {
                    cell.cellDataSource(model: sliders[indexPath.item])
                }
                return cell
            }
            return nil
        })
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SimpleTitleCVCell", for: indexPath) as? SimpleTitleCVCell
            if indexPath.section == 2 {
                view?.cellDataSourceCart(title: "Latest Products")
            } else if indexPath.section == 3 {
                view?.cellDataSourceCart(title: "Abaya")
            } else if indexPath.section == 4 {
                view?.cellDataSourceCart(title: "Categories")
            } else if indexPath.section == 5 {
                view?.cellDataSourceCart(title: "New Abaya")
            } else if indexPath.section == 6 {
                view?.cellDataSourceCart(title: "Dress")
            } else if indexPath.section == 7 {
                view?.cellDataSourceCart(title: "Categories")
            }
            return view
        }
        return dataSource
    }
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        if let sliders = self.example?.slider {
            snapshot.appendSections([0])
            snapshot.appendItems(sliders, toSection: 0)
        }
        if let categories = self.example?.categories {
            snapshot.appendSections([1])
            snapshot.appendItems(categories, toSection: 1)
        }
        if let newField = self.example?.newField {
            snapshot.appendSections([2])
            snapshot.appendItems(newField, toSection: 2)
        }
        if let sliders = self.example?.slider2 {
            snapshot.appendSections([3])
            snapshot.appendItems(sliders, toSection: 3)
        }
        if let categories = self.example?.categories2 {
            snapshot.appendSections([4])
            snapshot.appendItems(categories, toSection: 4)
        }
        if let newField = self.example?.newField2 {
            snapshot.appendSections([5])
            snapshot.appendItems(newField, toSection: 5)
        }
        if let sliders = self.example?.slider3 {
            snapshot.appendSections([6])
            snapshot.appendItems(sliders, toSection: 6)
        }
        if let categories = self.example?.categories3 {
            snapshot.appendSections([7])
            snapshot.appendItems(categories, toSection: 7)
        }
        initializedDataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func configureLayout() {
        self.collectionView!.register(cell: SliderCell.self)
        self.collectionView!.register(cell: CategoryCell.self)
        self.collectionView?.register(UINib(nibName: "SimpleTitleCVCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SimpleTitleCVCell")
        
        self.collectionView?.delegate = self
        collectionView!.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let section = self.createSingleListSection(height: 200)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
                return section
            } else if sectionIndex == 1 {
                return self.createSingleCountinousSequareListSection(width: 150, height: 150, sectionTop: 20)
            } else if sectionIndex == 2 || sectionIndex == 5 {
                let section  = self.createSingleCountinousSequareListSection(width: 150, height: 200)
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .absolute(55))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            } else if sectionIndex == 3 || sectionIndex == 6 {
                let section = self.createSingleListSection(height: 150)
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .absolute(55))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            } else if sectionIndex == 4 || sectionIndex == 7 {
                let section = self.createGridListSection(height: 120)
//                section.orthogonalScrollingBehavior = .continuous
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .absolute(55))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
            
            return nil
        })
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(at: indexPath)
    }
}
//extension HomeViewModel {
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
//    private func createDoubleListSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .estimated(150))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75),
//                                                     heightDimension: .estimated(235))
//        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
//                                                           subitem: layoutItem,
//                                                           count: 2)
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        return section
//    }
//    private func createGridListSection(width: CGFloat = 120,
//                                       height: CGFloat = 120) -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .absolute(height))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                     heightDimension: .absolute(height))
////        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
////                                                           subitem: layoutItem,
////                                                           count: 2)
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitem: layoutItem, count: 4)
//        layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        return section
//    }
//    private func createSingleCountinousSequareListSection(width: CGFloat, height: CGFloat, sectionTop: CGFloat = 0) -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
//                                              heightDimension: .absolute(height))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
//                                                     heightDimension: .absolute(height))
//        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
//                                                           subitem: layoutItem,
//                                                           count: 1)
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: sectionTop, leading: 0, bottom: 0, trailing: 0)
//        section.orthogonalScrollingBehavior = .continuous
//        
//        return section
//    }
//    private func createNoRecordListSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .estimated(100))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                     heightDimension: .estimated(100))
//        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
//                                                           subitem: layoutItem,
//                                                           count: 1)
//        let section = NSCollectionLayoutSection(group: layoutGroup)
//        return section
//    }
//}
