//
//  ImageLoaderManager.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 17/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {

    var imageURL: URL?

    func loadImageWithUrl(_ url: URL) {
        imageURL = url
        image = nil
        
        /// Load image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        /// Image not available in cache, load it from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
            })
        }).resume()
    }
}

