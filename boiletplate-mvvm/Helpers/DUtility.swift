//
//  DUtility.swift
//  sharaab Dev
//
//  Created by EDS on 17/02/2022.
//  Copyright © 2022 Ahmed Abdalla. All rights reserved.
//

import Foundation
import UIKit
import SwiftGifOrigin
import Lottie

class DUtility {
    static let shared = DUtility()
    private var image: UIImage?
    private var image2: UIImage?
    private var animationView: AnimationView?
    
    func gifNormalLoader() -> UIImage? {
        if let image = self.image {
            return image
        } else {
            self.image = UIImage.gifImageWithName("normal.loading")
            return self.image
        }
    }
    
    func gifLandscapeLoader() -> UIImage? {
        if let image = self.image2 {
            return image
        } else {
            self.image2 = UIImage.gifImageWithName("landscape.lloading")
            return self.image2
        }
    }
    
    func placeholder() -> UIImage {
        return UIImage(named: "placeholder")!
    }
    
    func loader(view: UIViewController, isHidden: Bool) {
        if self.animationView != nil {
            if isHidden {
                self.animationView?.removeFromSuperview()
            } else {
                // 2. Start AnimationView with animation name (without extension)
                //                self.animationView = .init(name: "coffee")
                
                self.animationView!.frame = view.view.bounds
                // 3. Set animation content mode
                self.animationView!.contentMode = .scaleAspectFit
                // 4. Set animation loop mode
                self.animationView!.loopMode = .loop
                // 5. Adjust animation speed
                self.animationView!.animationSpeed = 8
                view.view.addSubview(self.animationView!)
                // 6. Play animation
                self.animationView!.play()
            }
        } else {
            //            self.animationView = AnimationView()
            // 2. Start AnimationView with animation name (without extension)
            animationView = AnimationView(filePath: Bundle.main.path(forResource: "loading", ofType: "json")!, imageProvider: nil, animationCache: nil)
            animationView!.frame = view.view.bounds
            // 3. Set animation content mode
            animationView!.contentMode = .scaleAspectFit
            // 4. Set animation loop mode
            animationView!.loopMode = .loop
            // 5. Adjust animation speed
            animationView!.animationSpeed = 8
            view.view.addSubview(animationView!)
            // 6. Play animation
            animationView!.play()
        }
    }
    
    func emptyCart(view: UIViewController) {
        animationView = AnimationView(filePath: Bundle.main.path(forResource: "empty", ofType: "json")!, imageProvider: nil, animationCache: nil)
        let frame = CGRect(x: view.view.bounds.origin.x + 20, y: view.view.bounds.origin.y, width: view.view.bounds.size.width - 40, height: view.view.bounds.size.height)
        animationView!.frame = frame//view.view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 3
        view.view.addSubview(animationView!)
        animationView!.play()
    }
    
    func to<T: Codable>(object: T.Type, withName: String, completionHandler: @escaping ((_ object: T) -> Void)) {
        if let path = Bundle.main.path(forResource: withName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(string: path)!)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(object.self, from: data)
                completionHandler(jsonData)
              } catch let error {
                   // handle error
                  print(error)
              }
        }
    }
}
