//
//  SignupViewController.swift
//  Login-CoreData
//
//  Created by Mohan on 13/09/22.
//

import UIKit

//private var models = [User_Details]()

class SignupViewController: UITableViewController {
    
    struct Credential: Codable{
        var email:String
        var password: String
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgProfile.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        
        if imgProfile.image?.pngData() != imgSystem?.pngData(){
            // profile image selected
            if let email = txtEmail.text, let password = txtPassword.text, let username = txtUsername.text, let conPassword = txtConPassword.text{
                if username == ""{
                    print("Please enter username")
                    openAlert(title: "Alert", message: "Please enter username", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                }else if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }else if password == ""{
                    print("Please enter the password")
                    openAlert(title: "Alert", message: "Please enter the password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                }else if !password.validatePassword(){
                    print("Password is not valid")
                    openAlert(title: "Alert", message: "Password is not valid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                } else{
                    if conPassword == ""{
                        print("Please confirm password")
                        openAlert(title: "Alert", message: "Please confirm your password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    }else{
                        if password == conPassword{

                            
                           createitem(regname: username, regemail: email, regpassword: password)
                            self.navigationController?.popViewController(animated: true)

                            
                        }else{
                            print("password does not match")
                            openAlert(title: "Alert", message: "password does not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        }
                    }
                }
            }else{
                print("Please check your details")
            }
        }else{
            print("Please select profile picture")
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension SignupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            //picker.sourceType = .camera
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgProfile.image = img
        }
        dismiss(animated: true)
    }


    //CoreData
        func createitem(regname: String, regemail: String, regpassword: String) {

            let newItem = User_Details(context: context)
            newItem.name = regname
            newItem.email = regemail
            newItem.password = regpassword

            do {
                try context.save()
                print("item saved")
            } catch  {
                print("cannot save")
            }
        }

}
