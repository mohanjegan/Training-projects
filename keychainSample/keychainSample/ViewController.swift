//
//  ViewController.swift
//  keychainSample
//
//  Created by Mohan on 03/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPassword()
    }
    
    func getPassword(){
        guard let data = keychainManager.get(
            service: "facebook.com",
            account: "mohan"
        ) else {
            print("Failed to read Password")
            return
        }
        let password = String(
            decoding: data,
            as: UTF8.self
        )
        print("Read Password:\(password)")
    }
    
    func save(){
        do{
            try keychainManager.save(
                service: "facebook.com",
                account: "mohan",
                password: "something".data(using: .utf8) ?? Data()
            )
        }
        catch{
            print(error)
        }
    }
}

class keychainManager{
    enum KeychainError: Error{
        case duplicateEntry
        case unknown(OSStatus)
    }
    static func save(
        service: String,
        account: String,
        password: Data
    ) throws {
        //service, account, password, class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        guard  status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        print("saved")
    }
    static func get(
        service: String,
        account: String
    ) -> Data? {
        //service, account, class, return-data, matchLimit
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )
        guard  status == errSecSuccess else {
            return "Error getting password".data(using: .utf8)
        }
        return result as? Data
    }
}
