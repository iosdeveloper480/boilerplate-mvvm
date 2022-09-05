//
//  WAProfileImageView.swift
//  Asmaky
//
//  Created by EDS on 28/12/2021.
//

import UIKit

protocol WAProfileImageViewDelegate: AnyObject {
    func didTapPhoto()
}

class WAProfileImageView: UIView {
    
    @IBOutlet weak var backgroundView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var button : UIButton!
    
    weak var delegate: WAProfileImageViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView.cornerRadius(cornerRadius: 21)
    }
    
    func dataSource(imageURL: URL?) {
        if let imageURL = imageURL {
            APIClient.shared.AF.request(imageURL, method: .get).responseData { response in
                if let data = response.data {
                    self.imageView.image = UIImage(data: data)?.resizedImage(Size: CGSize(width: 40,
                                                                                          height: 40))
                }
            }
        } else {
            self.imageView.image = UIImage(named: "user")
        }
    }
    func update(image: UIImage?) {
        self.imageView.image = image
    }
    @IBAction func didTapPhotoButton(_ sender: UIButton) {
        self.delegate?.didTapPhoto()
    }
}
