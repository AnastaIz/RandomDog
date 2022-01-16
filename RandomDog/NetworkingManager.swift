//
//  NetworkingManager.swift
//  RandomDog
//
//  Created by Anastasia Izmaylova on 16.01.2022.
//

import Foundation
import UIKit

class NetworkingManager {
    static var shared = NetworkingManager()

    private init() {}
    
    func getDogImage(completion: @escaping (_ imageData: Data) -> Void) {
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
                                completion(imageData)
                            }
                            
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
        
                }.resume()
    
   
}
}


