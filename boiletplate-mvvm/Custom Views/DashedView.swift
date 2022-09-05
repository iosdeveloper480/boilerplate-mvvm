//
//  DashedView.swift
//  Asmaky
//
//  Created by mac on 15/11/2021.
//

import UIKit

class DashedView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let lineLayer = CAShapeLayer()
//        lineLayer.strokeColor = UIColor.gray.cgColor
//        lineLayer.lineWidth = 2
//        lineLayer.lineDashPattern = [4,4]
//        let path = CGMutablePath()
//        path.addLines(between: [CGPoint(x: 2.5, y: 0), CGPoint(x: 2.5, y: self.bounds.height)])
//        lineLayer.path = path
//        self.layer.addSublayer(lineLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.removeAll()
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.gray.cgColor
        lineLayer.lineWidth = 2
        lineLayer.lineDashPattern = [4,4]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 2.5), CGPoint(x: self.bounds.width, y: 2.5)])
        lineLayer.path = path
        self.layer.addSublayer(lineLayer)
    }
}
