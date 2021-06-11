//
//  Alerts.swift
//  Movies
//
//  Created by Григорий Виняр on 08.06.2021.
//

import UIKit

class Alerts {
    
    func showExitAlert(title: String, massage: String, titleForFirstAction: String, titleForSecondAction: String, controller: UIViewController) {
        let alertVC = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let alertActionOne = UIAlertAction(title: titleForFirstAction, style: .default) { _ in
            FirebaseStore().exitAction()
        }
        let alertActionTwo = UIAlertAction(title: titleForSecondAction, style: .cancel, handler: nil)
        
        alertVC.addAction(alertActionOne)
        alertVC.addAction(alertActionTwo)
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    func showRegistrationAlert(controller: UIViewController, message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    func showCommitAlert(controller: UIViewController) {
        let alertVC = UIAlertController(title: "You should be registrated", message: "", preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: "Registrate me", style: .default) { _ in
            Transitions().showModalAuth(controller: controller)
        }
        let secondAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertVC.addAction(firstAction)
        alertVC.addAction(secondAction)
        
        controller.present(alertVC, animated: true, completion: nil)
    }
}
