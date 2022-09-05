//
//  BaseViewModel.swift
//  Boiletplate
//
//  Created by EDS on 28/07/2022.
//

import Foundation
import UIKit

protocol BaseViewModelDelegate: AnyObject {
    func reloadData()
    func apply()
}

class BaseViewModel: NSObject {
    private weak var collectionView: UICollectionView?
    init(collectionView: UICollectionView?) {
        self.collectionView = collectionView
        super.init()
    }
    func createSingleListSection(height: CGFloat,
                                 isTableList: Bool = false,
                                 layoutEnvironment: NSCollectionLayoutEnvironment? = nil) -> NSCollectionLayoutSection {
        if isTableList {
            var listConfig = UICollectionLayoutListConfiguration(appearance: .plain)
            listConfig.showsSeparators = true
            let section = NSCollectionLayoutSection.list(using: listConfig,
                                                         layoutEnvironment: layoutEnvironment!)
            let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.reuseIdentifier)
            section.decorationItems = [sectionBackground]
            return section
        } else {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(height))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .absolute(height))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                                 subitems: [layoutItem])
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            let section = NSCollectionLayoutSection(group: layoutGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
    }
    func createSingleListSection(height: CGFloat,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .estimated(height))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        return section
    }
    func createSingleFullListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        return section
    }
    func createSingleCountinousSequareListSection(width: CGFloat,
                                                  height: CGFloat,
                                                  sectionTop: CGFloat = 0) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                              heightDimension: .absolute(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                                     heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionTop, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createSingleCountinousDynamic(width: CGFloat,
                                       height: CGFloat,
                                       sectionTop: CGFloat = 0) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(width),
                                              heightDimension: .absolute(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(width),
                                                     heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionTop, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createOptionsList(width: CGFloat,
                           height: CGFloat,
                           sectionTop: CGFloat = 0,
                           innerSpacing: CGFloat = 0) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(width),
                                              heightDimension: .estimated(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(width),
                                                     heightDimension: .estimated(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionTop, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = innerSpacing
        return section
    }
    
    func createCenteredCellsSection(width: CGFloat, height: CGFloat, sectionTop: CGFloat = 0) -> NSCollectionLayoutSection {
        var padding: CGFloat = 0.0
        if let frame = self.collectionView?.frame {
            let totalWidth = frame.size.width
            let widthOfCells = width * 3
            padding = totalWidth - widthOfCells
        }
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                              heightDimension: .absolute(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                                     heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionTop, leading: padding / 2, bottom: 0, trailing: padding / 2)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func createSingleCountinousSequareListSection2(width: CGFloat, height: CGFloat, sectionTop: CGFloat = 0) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                              heightDimension: .absolute(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                                     heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: sectionTop, leading: 10, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createGridListSection(height: CGFloat = 120,
                               column: Int = 4) -> NSCollectionLayoutSection {
        let interGroupSpacing: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .absolute(height))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitem: layoutItem,
                                                             count: column)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = interGroupSpacing
        return section
    }
    func createGridListSectionEstimated(height: CGFloat = 120,
                                        interGroupSpacing: CGFloat = 10,
                                        column: Int = 4,
                                        sectionBottomSpace: CGFloat = 0) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(height))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .estimated(height))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitem: layoutItem,
                                                             count: column)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: sectionBottomSpace,
                                                        trailing: 0)
        section.interGroupSpacing = interGroupSpacing
        return section
    }
    func createNoRecordListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(100))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .estimated(100))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        return section
    }
    
    func createNoRecordFullScreenSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.4))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalHeight(0.4))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 1)
        let section = NSCollectionLayoutSection(group: layoutGroup)
        return section
    }
}
