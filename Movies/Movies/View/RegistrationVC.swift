//
//  RegistrationVC.swift
//  Movies
//
//  Created by Григорий Виняр on 04.06.2021.
//

import UIKit
import Firebase

class RegistrationVC: UIViewController {
    
    //MARK: - Properties
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Sign Up"
                nameTF.isHidden = false
                questionLabel.isHidden = false
                buttonLogIn.setTitle("Sign Up", for: .normal)
            } else {
                titleLabel.text = "Sign In"
                nameTF.isHidden = true
                questionLabel.isHidden = true
                buttonLogIn.setTitle("Sign In", for: .normal)
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var buttonLogIn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupTextfields()
    }
    //Setup textFields
    func setupTextfields() {
        nameTF.attributedPlaceholder = NSAttributedString(string: "Enter your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTF.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Enter your Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    // Make textField delegates
    func setDelegates() {
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    // Change signUp state
    @IBAction func buttonLoginAction(_ sender: Any) {
        signup = !signup
    }
}

//MARK: - UITextFieldDelegate
extension RegistrationVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let name = nameTF.text else { return false }
        guard let email = emailTF.text else { return false }
        guard let password = passwordTF.text else { return false }
        
        // If user aren't registrated yet
        if signup {
            
            guard !name.isEmpty, !password.isEmpty, !email.isEmpty else {
                Alerts().showWarningAlert(controller: self, title: "", message: "You should enter all the fields", actionTitle: "Cancel")
                
                return false
            }
            
            FirebaseStore().existUser(name: name, email: email, password: password, controller: self)
            
        // If user have already registrated yet
        } else {
            FirebaseStore().signInWith(email: email, password: password, controller: self, message: "Email or Password is wrong")
        }
        return true
    }
}
