//
//  BannerSliderCell.swift
//  FATIMA
//
//  Created by EDS on 12/07/2022.
//

import UIKit

protocol BannerSliderCellDelegate: AnyObject {
    func didSelect(item: AnyHashable)
}

class BannerSliderCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: BannerSliderCellDelegate?
    
    private var sliders = [AnyHashable]()
    private var timer = Timer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer.invalidate()
        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "BannerSliderCVCell", bundle: nil), forCellWithReuseIdentifier: "BannerSliderCVCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    deinit {
        timer.invalidate()
    }
    
    func cellDataSource(sliders: [AnyHashable]) {
        self.sliders.append(contentsOf: sliders)
        self.collectionView.reloadData()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: HConstants.bannerTimer, repeats: true, block: { [weak self] timer in
            self?.animateScroll()
        })
    }
    @objc private func animateScroll() {
        let cellSize = self.frame.size
        let contentOffset = collectionView.contentOffset
        if collectionView.contentSize.width <= collectionView.contentOffset.x + cellSize.width {
            let r = CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            collectionView.scrollRectToVisible(r, animated: true)
        } else {
            let xx = collectionView.frame.origin.x * 4
            let r = CGRect(x: contentOffset.x + cellSize.width - xx, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            collectionView.scrollRectToVisible(r, animated: true)
        }
    }
}

//extension BannerSliderCell: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.sliders.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = BannerSliderCVCell.initialize(with: collectionView, indexPath: indexPath)
//        cell.cellDataSource(model: self.sliders[indexPath.row])
//        return cell
//    }
//}
extension BannerSliderCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.sliders[indexPath.row]
        self.delegate?.didSelect(item: item)
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        timer.invalidate()
        startTimer()
    }
}
extension BannerSliderCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}
