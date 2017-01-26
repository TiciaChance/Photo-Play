//
//  UnsplashRandomImgAPI.swift
//  Photo Play
//
//  Created by Ticia Chance on 1/25/17.
//  Copyright © 2017 Ticia Chance. All rights reserved.
//

import UIKit
import Alamofire

typealias UnsplashCompletion = (UnsplashResponse) -> Void

enum UnsplashResponse {
    case success(response: UnsplashResponseData)
    case failure(error: Error)
}

struct UnsplashResponseData {
    public let results: [Photos]
}


class UnsplashRandomImgAPI: NSObject {
    
    let urlString = "https://api.unsplash.com/photos/random/"
    let appID = "86e916bf32bc92c54e2979f81c2f438071889c15c7e3cdb805a8e226c21c723e"
    
    func fetchPhotos(completion: @escaping UnsplashCompletion) {
        
        let baseURL = URL(string: urlString)
        if let fullURL = URL(string: "?client_id=\(appID)", relativeTo: baseURL) {
            
            Alamofire.request(fullURL).responseJSON(completionHandler: { (response) in

                if let data = response.result.value {
                    let photo = PhotoParser.photoParser(json: data)
                    completion(.success(response: UnsplashResponseData(results: photo)))
                } else {
                    completion(.failure(error: response.result.error ?? NSError()))
                }
            
            })
        }
    }
}
