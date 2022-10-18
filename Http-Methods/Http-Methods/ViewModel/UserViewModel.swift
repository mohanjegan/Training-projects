//
//  userViewModel.swift
//  Http-Methods
//
//  Created by Mohan on 14/10/22.
//

import Foundation
import UIKit


class UserViewModel {
    var usersList = [UserInfo]()
    
    func postFunc (completionHandler: @escaping (Bool) -> ()){
        guard let postUrl = URL(string: baseUrl + registration) else { return }
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.setValue("application/JSON", forHTTPHeaderField: "Contenet-Type")
        request.setValue("httpBody", forHTTPHeaderField: "post")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                do{
                    self.usersList = try JSONDecoder().decode([UserInfo].self, from: data!)
                    completionHandler(true)
                }
                catch{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
            }
            else{
                completionHandler(false)
            }
        }.resume()
    }
}


