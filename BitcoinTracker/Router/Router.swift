//
//  Router.swift
//  BitcoinTracker
//
//  Created by Anusha Verma on 13/07/21.
//

import Foundation
import UIKit

class Router {

    static let shared = Router()
    private init() { }
    var currentWindow: UIWindow?
    var currentViewController : UIViewController?
    var userActivity: NSUserActivity?
    
    func setRootView(viewController: UIViewController, toAnimate: Bool = true) {

        guard let applicationWindow = currentWindow else { return }
        currentViewController = viewController
        let animationDuration = toAnimate ? 0.5 : 0.0
        UIView.transition(with: applicationWindow, duration: animationDuration, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
            applicationWindow.rootViewController = viewController
            applicationWindow.makeKeyAndVisible()
        }, completion: nil)

    }
    
    func setInitialViewController() {

        let initialVc = BitcoinViewController()
        self.setRootView(viewController: initialVc, toAnimate: true)
    }
}

