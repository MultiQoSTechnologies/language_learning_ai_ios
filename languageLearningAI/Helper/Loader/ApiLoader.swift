//
//  ApiLoader.swift
//  queso
//
//  Created by Krishna Soni on 07/06/21.
//

import UIKit
import NVActivityIndicatorView

class ApiLoader: UIView {
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var lblMessage: UILabel!
}

extension ApiLoader {
    
    func show(type: NVActivityIndicatorType = .ballSpinFadeLoader, message: String? = nil)  {
        
        guard let window = UIApplication.sceneDelegate?.window else {
            return
        }
        
        self.frame = window.frame
        window.addSubview(self)
        activityIndicator.type = type
        activityIndicator.startAnimating()
        lblMessage.text = message ?? ""
    }
    
    func hide()  {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}
