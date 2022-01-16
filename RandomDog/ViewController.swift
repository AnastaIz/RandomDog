//
//  ViewController.swift
//  RandomDog
//
//  Created by Anastasia Izmaylova on 16.01.2022.
//

import UIKit

let link = "https://random.dog/woof.json"

class ViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    @IBAction func getADogButton(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        reloadInputViews()
        
        NetworkingManager.shared.getDogImage { imageData in
            self.dogImage.image = UIImage(data: imageData)
        }
        
    }
        
}
    

