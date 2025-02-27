//
//  UIView+Extension.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit
import ObjectiveC.runtime

extension UIView {
    
    /// This static Computed property is used to getting any UIView from XIB. This Computed property returns UIView? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("UIView!") then application will crash.
    static var viewFromXib: UIView? {
        return self.viewWithNibName(strViewName: "\(self)")
    }
    
    /// This static method is used to getting any UIView with specific name.
    ///
    /// - Parameter strViewName: A String Value of UIView.
    /// - Returns: This Method returns UIView? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("UIView!") then application will crash.
    static func viewWithNibName(strViewName: String) -> UIView? {
        
        guard let view = Bundle.MainBundle.loadNibNamed(
            strViewName,
            owner: self,
            options: nil)?.first as? UIView else {
            return nil
        }
        
        return view
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue; layer.masksToBounds = true }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set { layer.borderColor = newValue?.cgColor }
    }

}

private var roundedCornerKey: UInt8 = 0

extension UIView {

    @IBInspectable
    var roundedCorner: Bool {
        get {
            return objc_getAssociatedObject(self, &roundedCornerKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &roundedCornerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            // Ensure swizzling is performed once.
            UIView.swizzleLayoutSubviews
            // Immediately update if possible.
            updateCornerRadius()
        }
    }
    
    // Method to update the corner radius
    private func updateCornerRadius() {
        if roundedCorner {
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
    // Swizzle layoutSubviews to update the corner radius when layout changes.
    private static let swizzleLayoutSubviews: Void = {
        let originalSelector = #selector(UIView.layoutSubviews)
        let swizzledSelector = #selector(UIView.swizzled_layoutSubviews)
        
        guard let originalMethod = class_getInstanceMethod(UIView.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector) else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }()
    
    @objc func swizzled_layoutSubviews() {
        // This actually calls the original layoutSubviews due to swizzling.
        self.swizzled_layoutSubviews()
        // Update the corner radius after layout.
        updateCornerRadius()
    }
}
