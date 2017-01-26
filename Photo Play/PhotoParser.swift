//
//  PhotoParser.swift
//  Photo Play
//
//  Created by Ticia Chance on 1/25/17.
//  Copyright © 2017 Ticia Chance. All rights reserved.
//

import UIKit

class PhotoParser: NSObject {
    
    class func photoParser(json: Any) -> [Photos] {
        
        var randomPhoto = [Photos]()
        
        if let JSON = json as? [String : Any],
            let photoURLs = JSON["urls"] as? [String: Any],
            let photoURLString = photoURLs["regular"] as? String,
            let userInfo = JSON["user"] as? [String : Any],
            let name = userInfo["name"] as? String,
            let photoURL = URL(string: photoURLString),
            let imgData = NSData(contentsOf: photoURL),
            let image = UIImage(data: imgData as Data) {
            
            let photo = Photos(randomPhoto: image, artist: name)
            randomPhoto.append(photo)
        }
        return randomPhoto
    }
    
}

struct Photos {
    
    let randomPhoto: UIImage
    let artist : String
}
