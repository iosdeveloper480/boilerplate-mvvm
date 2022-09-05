//
//  BottomSheetVC.swift
//  Asmaky
//
//  Created by mac on 17/11/2021.
//

import Foundation
import FittedSheets

extension SheetViewController {
    @objc func openFullVC() {
        if self.autoAdjustToKeyboard {
            self.resize(to: .marginFromTop(100))
        }
    }
//    @objc func fixVC(size: SheetSize) {
//        if self.autoAdjustToKeyboard {
//            
//        }
//    }
}
