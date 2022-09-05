//
//  WATrashView.swift
//  Asmaky
//
//  Created by EDS on 27/12/2021.
//

import UIKit

protocol WALeftBarIconButtonDelegate: AnyObject {
    func didTapTrashButton(isDeleting: Bool)
    func didTapLeftBarButton()
}
extension WALeftBarIconButtonDelegate {
    func didTapTrashButton(isDeleting: Bool) {}
    func didTapLeftBarButton() {}
}

class WALeftBarIconButtonView: UIView {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var backgroundView : UIView!
    @IBOutlet weak var button : UIButton!
    
    weak var delegate: WALeftBarIconButtonDelegate?
    private var isDeleting = true
    private var isAddButton = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundView.cornerRadius(cornerRadius: 20)
    }
    
    func dataSource(isDeleting: Bool) {
        if isDeleting {
            self.imageView.image = UIImage(systemName: "checkmark")
        } else {
            self.imageView.image = UIImage(systemName: "trash.fill")
        }
        self.isDeleting.toggle()
    }
    
    @IBAction func didTapTrashButton(_ sender: UIButton) {
        if self.isAddButton {
            self.delegate?.didTapLeftBarButton()
        } else {
            self.delegate?.didTapTrashButton(isDeleting: self.isDeleting)
        }
    }
    
    func addButtonDataSource() {
        self.isAddButton = true
        self.imageView.image = UIImage(systemName: "plus")
    }
}
