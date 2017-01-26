//
//  ViewController.swift
//  Photo Play
//
//  Created by Ticia Chance on 1/25/17.
//  Copyright © 2017 Ticia Chance. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var test = UnsplashRandomImgAPI()
    var photos = [Photos]()
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       updateImageView()
    }
    
    func updateImageView() {
        test.fetchPhotos { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(response: let responseData):
                self.photos = responseData.results
                
                DispatchQueue.main.async(execute: {
                    for photo in self.photos {
                     self.photoImageView.image = photo.randomPhoto
                        self.artistNameLabel.text = photo.artist

                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

