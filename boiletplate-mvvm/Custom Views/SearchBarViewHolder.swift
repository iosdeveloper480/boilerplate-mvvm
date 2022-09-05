//
//  SearchBarViewHolder.swift
//  app
//
//  Created by EDS on 01/09/2022.
//  Copyright © 2022 Ahmed Abdalla. All rights reserved.
//

import Foundation
import UIKit

class SearchBarViewHolder: UIView {
    
    let searchBar: UISearchBar
    
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        
        addSubview(searchBar)
    }
    
    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
