//
//  RKLoading.swift
//  ShuffleSongs
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import UIKit

class RKLoading {
    
    private static let loadingView = UIView(frame: UIScreen.main.bounds)
    private static let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    private static func createLoadingView() {
        loadingView.backgroundColor = UIColor(red: 55/255, green: 38/255, blue: 55/255, alpha: 1)
        
        activityIndicator.alpha = 1.0
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        
        loadingView.bringSubviewToFront(activityIndicator)
    }
    
    static func showLoading(in view: UIView? = nil) {
        createLoadingView()
        showStatusLoading()
        
        if view != nil {
            view?.insertSubview(loadingView, at: 0)
        } else {
            UIApplication.shared.keyWindow?.addSubview(loadingView)
        }
        
        
    }
    
    static func hideLoading() {
        hideStatusLoading()
        DispatchQueue.main.async {
            activityIndicator.removeFromSuperview()
            loadingView.removeFromSuperview()
        }
    }
    
    static func showStatusLoading() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    static func hideStatusLoading() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
