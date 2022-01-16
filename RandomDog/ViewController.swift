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
        activityIndicator.isHidden = true
        
    }

    @IBAction func getADogButton(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
      
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let dog = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.global().async {
                    guard let url = URL(string: dog.url) else { return }
                    guard let imageData = try? Data(contentsOf: url) else { return }
                    
                    DispatchQueue.main.async {
                        self.reloadInputViews()
                        self.dogImage.image = UIImage(data: imageData)
                        self.activityIndicator.stopAnimating()
                    }
                }
                print(dog)
            } catch {
                print(error.localizedDescription)
            }

        }.resume()
        
            
        
        
    }
    
    
    
}
