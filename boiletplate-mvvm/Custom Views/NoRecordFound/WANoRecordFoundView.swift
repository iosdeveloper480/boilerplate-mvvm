//
//  WANoRecordFoundView.swift
//  Asmaky
//
//  Created by EDS on 04/01/2022.
//

import Foundation
import SwiftUI

struct WANoRecordFoundViewUI: View {
    
    @State var imageName: String
    @State var title: String
    @State var description: String
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                //                Image(systemName: imageName)
                //                    .interpolation(.high)
                //                    .resizable()
                //                    .frame(width: 100,
                //                           height: 100,
                //                           alignment: .center)
                Text(title)
                    .fontWeight(.bold)
                    .font(Font.system(.title))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)
                Text(description)
                    .fontWeight(.regular)
                    .font(Font.system(.body))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

func showNoRecordFound(vc: UIViewController,
                       imageName: String = "",
                       title: String,
                       description: String) {
    let fromController = UIHostingController(rootView: WANoRecordFoundViewUI(imageName: imageName,
                                                                             title: title,
                                                                             description: description))
    if let view = fromController.view {
        view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(view)
        view.topAnchor.constraint(equalTo: vc.view.topAnchor,
                                  constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor,
                                     constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor,
                                      constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor,
                                       constant: 0).isActive = true
        vc.addChild(fromController)
    }
}
