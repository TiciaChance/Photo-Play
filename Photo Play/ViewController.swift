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

    
 
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        UIImageWriteToSavedPhotosAlbum(photoImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your next hairstyle has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

