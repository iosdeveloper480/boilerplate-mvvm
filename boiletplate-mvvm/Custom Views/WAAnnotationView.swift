//
//  WAAnnotationView.swift
//  Asmaky
//
//  Created by EDS on 11/01/2022.
//

import Foundation
import UIKit

class WAAnnotationView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        nibSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "WAAnnotationView", bundle: nil)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func update(title: String) {
        self.titleLabel.text = title
        self.iconImageView.image = UIImage(named: "place")
    }
}
