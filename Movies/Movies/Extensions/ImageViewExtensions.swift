//
//  ImageViewExtensions.swift
//  Movies
//
//  Created by Григорий Виняр on 12.06.2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func load(imageFrom imageUrl: String) {
        let placeHolder = UIImage(systemName: "photo")
        
        guard let imageURL = URL(string: imageUrl) else {
            self.image = placeHolder
            return
        }
        
        sd_setImage(with: imageURL) { downloadedImage, error, cacheType, url in
            self.image = downloadedImage
        }
    }
}
