//
//  Loader.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/11/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import Lottie
import SkeletonView
import Emity

protocol LoadableViewControllerProtocol {
    func willSkeleton() -> Bool
    func hideLoading() -> Void
    func showLoading() -> Void
    func loadableComplete() -> Void
}

class LoadableViewController : UIViewController, LoadableViewControllerProtocol {
    let eventEmitter = Emity()
    
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
    
    func willSkeleton() -> Bool {
        return true;
    }
    
    func loadableComplete() {
        eventEmitter.emit("loadableComplete")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if willSkeleton()
        {
            view.showAnimatedSkeleton()
            
            eventEmitter.on("loadableComplete", callback: {
                self.view.hideSkeleton()
            })
        }
    }
}
