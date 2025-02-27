//
//  File.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//
 
import Foundation
import UIKit
import NVActivityIndicatorView


// MARK: - Extension of UIApplication -
extension UIApplication {
    
    /// This will return the application AppDelegate instance.
    ///
    ///  This could be nil value also, while using this "appDelegate" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    /// This will return the AppDelegate UIWindow instance.
    ///
    ///  This could be nil value also, while using this "appDelegateWindow" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    static var window: UIWindow? {
        return UIApplication.sceneWindow?.window
    }
    
    /// This will return the AppDelegate rootViewController instance.
    ///
    ///  This could be nil value also, while using this "appDelegateWindowRootViewController" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    static var rootViewController: UIViewController? {
        return UIApplication.window?.rootViewController
    }
    
    /// This will return the application SceneDelegate instance.
    ///
    ///  This could be nil value also, while using this "sceneDelegate" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    static var sceneDelegate: SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
    
    /// This will return the SceneDelegate UIWindow instance.
    ///
    ///  This could be nil value also, while using this "sceneWindow" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    static var sceneWindow: UIWindow? {
        return UIApplication.sceneDelegate?.window
    }
    
    /// This will return the SceneDelegate  instance.
    ///
    ///  This could be nil value also, while using this "sceneWindowRootViewController" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    static var sceneWindowRootVC: UIViewController? {
        return UIApplication.sceneWindow?.rootViewController
    }
    
    
    func topMostVC(viewController: UIViewController? = UIApplication.sceneWindowRootVC) -> UIViewController? {
        
        if let navigationViewController = viewController as? UINavigationController {
            return UIApplication.shared.topMostVC(viewController: navigationViewController.visibleViewController)
        }
        if let tabBarViewController = viewController as? UITabBarController {
            if let selectedViewController = tabBarViewController.selectedViewController {
                return UIApplication.shared.topMostVC(viewController: selectedViewController)
            }
        }
        if let presentedViewController = viewController?.presentedViewController {
            return UIApplication.shared.topMostVC(viewController: presentedViewController)
        }
        return viewController
    }
    
}

// MARK:- NVActivityIndicatorView -
extension UIApplication {
    
    /// https://github.com/ninjaprox/NVActivityIndicatorView
    class func showActivityIndicator(type: NVActivityIndicatorType? = nil, message: String? = nil) {
        UIApplication.hideActivityIndicator()
        
        DispatchQueue.main.async {
            guard let apiLoader = ApiLoader.viewFromXib as? ApiLoader else {
                return
            }
            
            apiLoader.show(message: message)
        }
    }

    class func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            guard let window = UIApplication.sceneDelegate?.window else {
                return
            }
            
            for view in window.subviews {
                if let activityIndicatorView = view as? ApiLoader {
                    activityIndicatorView.hide()
                    break
                }
            }
        }
    }
    
    class func activityIndicator(color: UIColor = .white) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        indicator.style = .medium
        indicator.color = color
        indicator.startAnimating()
        
        return indicator
    }
} 

extension Bundle {
    
    static var MainBundle: Bundle {
        return Bundle.main
    }
    
    static var BundleIdentifier: String? {
        return MainBundle.bundleIdentifier
    }
    
}
