//
//  DetailViewController.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/17.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var data: Int!
    var cache: LRUCache<UIImage, Int>!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "Cache Count: \(cache.count)"

        if let image = cache[data] {
            imageView.image = image
        } else {
            requestImage(data: data) { [weak self] image in
                guard let strongSelf = self else { return }
                strongSelf.imageView.image = image
                strongSelf.cache[strongSelf.data] = image
                strongSelf.title = "Cache Count: \(strongSelf.cache.count)"
            }
        }
    }

    func requestImage(data: Int, completion: @escaping (UIImage) -> Void) {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()

        // 0.5秒後に画像を設定する(ネットワーク経由での画像取得をシミュレートする)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.activityIndicatorView.stopAnimating()
            strongSelf.activityIndicatorView.isHidden = true

            let image = UIImage(named: "image-\(data)")!
            completion(image)
        }
    }
}
