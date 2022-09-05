//
//  WAFilterView.swift
//  Asmaky
//
//  Created by EDS on 27/12/2021.
//

import UIKit
protocol WAFilterViewDelegate: AnyObject {
    func didTapButton()
}
class WAFilterView: UIView {

    @IBOutlet weak var backgroundView : UIView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var button : UIButton!
    
    weak var delegate: WAFilterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView.cornerRadius(cornerRadius: 18)
    }
    
    func dataSource(date: String) {
        self.titleLabel.text = date
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        self.delegate?.didTapButton()
    }
}
