//
//  DownloadImage.swift
//  Aisle
//
//  Created by Gokul A S on 24/09/22.
//

import Foundation
import UIKit

// MARK: UIIMageView Fetch function
extension UIImageView {
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        if self.image == nil{
              self.image = PlaceHolderImage
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
