//
//  Loader.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/11/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import Lottie

class LoadableViewController : UIViewController {
    let animationView = LOTAnimationView(name: "LoadingAnimation")

    func showLoading() -> Void {
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.backgroundColor = UIColor.white
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        animationView.play()
    }
    
    func hideLoading() -> Void {
        animationView.removeFromSuperview()
    }
}
