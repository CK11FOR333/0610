//
//  ImageManager.swift
//  0610
//
//  Created by Chris on 2019/7/4.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

let imageManager = ImageManager.sharedInstance

final class ImageManager {

    // MARK: - Singleton
    static let sharedInstance = ImageManager()

    // MARK: - Variables

    fileprivate let photoCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024, preferredMemoryUsageAfterPurge: 60 * 1024 * 1024)

    // MARK: - public function

    func loadImage(with urlString: String, completion: @escaping ((UIImage) -> Void)) {
        if let image = self.cachedImage(urlString) {
            completion(image)
        } else {
            let _ = self.downloadImageWithURL(urlString) { image -> Void in
                completion(image)
            }
        }
    }

    // MARK: - Download Images

    fileprivate func downloadImageWithURL(_ urlString: String, completion: @escaping ((UIImage) -> Void)) -> Request {
        let url = URL(string: urlString)!
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
            self.cacheImage(image, urlString: urlString)
        }
    }

    //MARK: - Image Caching

    fileprivate func cacheImage(_ image: Image, urlString: String) {
        photoCache.add(image, withIdentifier: urlString)
    }

    fileprivate func cachedImage(_ urlString: String) -> Image? {
        return photoCache.image(withIdentifier: urlString)
    }

}
