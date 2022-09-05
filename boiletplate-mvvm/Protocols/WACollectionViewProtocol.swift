//
//  WACollectionViewProtocol.swift
//  Asmaky
//
//  Created by EDS on 28/02/2022.
//

import Foundation
import UIKit

protocol WACollectionViewCellInit {
    static func initialize(with: UICollectionView,
                           indexPath: IndexPath) -> Self
}
extension WACollectionViewCellInit where Self: UICollectionViewCell {
    static func initialize(with: UICollectionView,
                           indexPath: IndexPath) -> Self {
        return with.dequeueReusableCell(withReuseIdentifier: String(describing: Self.self),
                                        for: indexPath) as! Self
    }
}
extension UICollectionViewCell: WACollectionViewCellInit {}



protocol WACollectionViewProtocol {
    func register(cell: UICollectionViewCell.Type)
    func register(reusableview: UICollectionReusableView.Type)
}
extension WACollectionViewProtocol where Self: UICollectionView {
    func register(cell: UICollectionViewCell.Type) {
        self.register(UINib(nibName: String(describing: cell.self),
                            bundle: nil),
                      forCellWithReuseIdentifier: String(describing: cell.self))
    }
    func register(reusableview: UICollectionReusableView.Type) {
        self.register(UINib(nibName: String(describing: reusableview.self), bundle: nil),
                      forSupplementaryViewOfKind: String(describing: reusableview.self),
                      withReuseIdentifier: String(describing: reusableview.self))
    }
}
extension UICollectionView: WACollectionViewProtocol {}
