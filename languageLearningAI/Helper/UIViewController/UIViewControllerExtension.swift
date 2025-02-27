//
//  UIViewController+Extension.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MessageUI
import SafariServices

typealias alertActionHandler = ((UIAlertAction) -> ())?
typealias alertTextFieldHandler = ((UITextField) -> ())

typealias popUpCompletionHandler = (() -> ())

extension UIViewController {
    
  
}

typealias blockHandler = ((_ data: Any?, _ error: String?) -> ())

// MARK: - Extension of UIViewController set the Block and getting back with some data(Any Type of Data) AND error message(String).
extension UIViewController {
    
    /// This Private Structure is used to create all AssociatedObjectKey which will be used within this extension.
    private struct blockKey {
        static var blockHandler = "blockHandler"
    }
    
    /// A Computed Property (only getter) of blockHandler(data , error) , Both data AND error are optional so you can pass nil if you don't want to share anything. This Computed Property is optional , it might be return nil so please use if let OR guard let.
    var block: blockHandler? {
        guard let block = objc_getAssociatedObject(self, &blockKey.blockHandler) as? blockHandler else { return nil }
        return block
    }
    
    /// This method is used to set the block on CurrentController for getting back with some data(Any Type of Data) AND error message(String).
    ///
    /// - Parameter block: This block contain data(Any Type of Data) AND error message(String) to let you help in CurrentController. Both data AND error might be nil , in this case to prevent the crash please use if let OR guard let.
    func setBlock(block: @escaping blockHandler) {
        objc_setAssociatedObject(self, &blockKey.blockHandler, block, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

// MARK: - Extension of UIViewController.
extension UIViewController {
    
    /// This static method is used for initialize the UIViewController with nibName AND bundle.
    /// - Returns: This Method returns instance of UIViewController.
    static func initWithNibName() -> Self {
        return self.init(nibName: "\(self)", bundle: nil)
    }
    
    var isVisible: Bool {
        return self.isViewLoaded && (self.view.window != nil)
    }
    
    var isPresentted: Bool {
        return self.isBeingPresented || self.isMovingToParent
    }
    
    var isDismissed: Bool {
        return self.isBeingDismissed || self.isMovingFromParent
    }
}



