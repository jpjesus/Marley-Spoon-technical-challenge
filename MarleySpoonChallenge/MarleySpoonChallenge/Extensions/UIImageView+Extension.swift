//
//  UIImageView+Extension.swift
//  MarleySpoonChallenge
//
//  Created by Jesus Parada on 23/07/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    var imageCache: NSCache<NSString, UIImage> {
        get { return NSCache<NSString, UIImage>() }
    }
    
    func loadImage(withUrl url: URL?, fileName: String) {
        if url == nil { return }
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: fileName as NSString)  {
            self.image = cachedImage
            return
        }
        
        let loaderColor = traitCollection.userInterfaceStyle == .dark ? UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium) :
            UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        let activityIndicator: UIActivityIndicatorView = loaderColor
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let data = data,
               let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: fileName as NSString)
                DispatchQueue.main.async {
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
