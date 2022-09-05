//
//  WATableViewCell.swift
//  Asmaky
//
//  Created by EDS on 02/01/2022.
//

import Foundation
import UIKit

protocol WATableViewCellInit {
    static func initialize(with: UITableView,
                           indexPath: IndexPath) -> Self
}
extension WATableViewCellInit where Self: UITableViewCell {
    static func initialize(with: UITableView,
                           indexPath: IndexPath) -> Self {
        return with.dequeueReusableCell(withIdentifier: String(describing: Self.self),
                                        for: indexPath) as! Self
    }
}
extension UITableViewCell: WATableViewCellInit {}



protocol WATableView {
    func register(cell: UITableViewCell.Type)
}
extension WATableView where Self: UITableView {
    func register(cell: UITableViewCell.Type) {
        self.register(UINib(nibName: String(describing: cell.self),
                            bundle: nil),
                      forCellReuseIdentifier: String(describing: cell.self))
    }
}
extension UITableView: WATableView {}
