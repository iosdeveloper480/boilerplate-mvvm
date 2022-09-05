//
//  DiagonalLineView.swift
//  Asmaky
//
//  Created by EDS on 27/06/2022.
//

import Foundation
import UIKit

class DiagonalLineView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.removeAll()
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: bounds.height * (1 - 0.1)))
        linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height * 0.1))
        
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.lineWidth = 2
        lineLayer.path = linePath.cgPath
        self.layer.addSublayer(lineLayer)
    }
}
