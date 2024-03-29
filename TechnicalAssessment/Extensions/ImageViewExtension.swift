//
//  ImageViewExtension.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 15/03/2024.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
   
    func downloaded(from urlString: String, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        guard let url = URL(string: urlString) else {return}
        if let image  = imageCache.object(forKey: urlString as NSString) as? UIImage{
            self.image = image
            return
           }
            DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf:url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.sync {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
