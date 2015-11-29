//
//  ImageTableViewCell.swift
//  BusquetsSample
//
//  Created by SatoShunsuke on 2015/11/29.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var customImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCustomImageUrlString(urlString :String) {

        // use cacha if exists
        let cache = imageCache.get(urlString)
        if cache != nil {
            self.customImageView.image = cache
            return
        }

        dispatch_async_global {
            let url = NSURL(string: urlString)
            if let existUrl = url {
                let data = NSData(contentsOfURL: existUrl)
                if let existData = data {
                    let image = UIImage(data: existData)!
                    imageCache.set(urlString, value: image)
                    dispatch_async_main {
                        self.customImageView.image = image
                    }
                }
            }
        }
    }

}

// helper

func dispatch_async_main(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
}

func dispatch_async_global(block: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
}
