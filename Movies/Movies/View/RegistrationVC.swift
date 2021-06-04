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

        setDelegates()
    }
    //MARK: - Make textField delegates
    func setDelegates() {
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    //MARK: - Change signUp state
    @IBAction func buttonLoginAction(_ sender: Any) {
        signup = !signup
    }
    
    //MARK: - Errors catching
    func showAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Fill in all the fields", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

//MARK: - UITextFieldDelegate
extension RegistrationVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let name = nameTF.text else { return false }
        guard let email = emailTF.text else { return false }
        guard let password = passwordTF.text else { return false }
        
        if signup {
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name , "email" : email])
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                showAlert()
            }
        } else {
            if !email.isEmpty && !password.isEmpty {
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
                    if error == nil {
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                showAlert()
            }
        }
        return true
    }
}
