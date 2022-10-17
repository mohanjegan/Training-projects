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
    
    func postFunc (completionHandler: @escaping (() -> Void)){
        let urlString = "https://6347b393db76843976b03c63.mockapi.io/api/registrations"
        guard let postUrl = URL(string: urlString) else{return}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.setValue("application/JSON", forHTTPHeaderField: "Contenet-Type")
        request.setValue("httpBody", forHTTPHeaderField: "post")
        
        let user1 = UserInfo(createdAt: "\(Date())", name: "Dennis", avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1013.jpg", id: "10")
        let user2 = UserInfo(createdAt: "\(Date())", name: "Richard", avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1017.jpg", id: "11")
        do{
            let jsonItem = try JSONEncoder().encode([user1, user2])
            request.httpBody = jsonItem
        }catch{
            print("it's not json")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                let str = String(data: data!, encoding: .utf8)
                print(str!)
                do{
                    self.usersList = try JSONDecoder().decode([UserInfo].self, from: data!)
                    completionHandler()
                }
                catch{
                    print("json error")
                    completionHandler()
                }
            }
        }.resume()
    }
}


