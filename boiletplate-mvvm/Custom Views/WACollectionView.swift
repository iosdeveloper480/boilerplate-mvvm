//
//  WACollectionView.swift
//  Asmaky
//
//  Created by EDS on 24/02/2022.
//

import UIKit
protocol WACollectionViewDelegate: AnyObject {
    func waCollectionView(_ waCollectionView: WACollectionView, didSelectItemAt indexPath: IndexPath)
}
extension WACollectionViewDelegate {
    func waCollectionView(_ waCollectionView: WACollectionView, didSelectItemAt indexPath: IndexPath) {}
}

protocol WACollectionViewDataSourceDelegate: AnyObject {
    func numberOfSections(in waCollectionView: WACollectionView) -> Int
    func waCollectionView(_ waCollectionView: WACollectionView, numberOfItemsInSection section: Int) -> Int
    func waCollectionView(_ waCollectionView: WACollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func waCollectionView(_ waCollectionView: WACollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func waCollectionView(_ waCollectionView: WACollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func waCollectionView(_ waCollectionView: WACollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
}
extension WACollectionViewDataSourceDelegate {
    func waCollectionView(_ waCollectionView: WACollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    func waCollectionView(_ waCollectionView: WACollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

class WACollectionView: UICollectionView {
    
    weak var selfdataSource: WACollectionViewDataSourceDelegate?
    weak var selfdeleagte: WACollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
}
extension WACollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.selfdataSource?.numberOfSections(in: self) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selfdataSource?.waCollectionView(self, numberOfItemsInSection: section) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.selfdataSource?.waCollectionView(self, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self.selfdataSource?.waCollectionView(self, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.selfdataSource?.waCollectionView(self, layout: collectionViewLayout, referenceSizeForHeaderInSection: section) ?? CGSize.zero
    }
}

extension WACollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selfdeleagte?.waCollectionView(self, didSelectItemAt: indexPath)
    }
}
extension WACollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.selfdataSource?.waCollectionView(self, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize.zero
    }
}
