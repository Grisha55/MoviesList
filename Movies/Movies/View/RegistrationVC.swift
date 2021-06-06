//
//  RegistrationVC.swift
//  Movies
//
//  Created by Григорий Виняр on 04.06.2021.
//

import UIKit
import Firebase

class RegistrationVC: UIViewController {
    
    var registrationViewModel: RegistrationViewModel?
    
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
        
        registrationViewModel = RegistrationViewModel()
        setDelegates()
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
                
                registrationViewModel?.showAlert(controller: self, message: "You shoul enter all the fields")
                
                return false
            }
            
            registrationViewModel?.existUser(name: name, email: email, password: password, controller: self)
            
        // If user have already registrated yet
        } else {
            registrationViewModel?.signInWith(email: email, password: password, controller: self, message: "Please enter all the fields")
        }
        return true
    }
}
