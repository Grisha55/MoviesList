//
//  Alerts.swift
//  Movies
//
//  Created by Григорий Виняр on 08.06.2021.
//

import UIKit

class Alerts {
    
    func showExitAlert(title: String, massage: String,titleForFirstAction: String, titleForSecondAction: String, controller: UIViewController) {
        let alertVC = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let alertActionOne = UIAlertAction(title: titleForFirstAction, style: .default) { _ in
            DataStore().exitAction()
        }
        let alertActionTwo = UIAlertAction(title: titleForSecondAction, style: .cancel, handler: nil)
        
        alertVC.addAction(alertActionOne)
        alertVC.addAction(alertActionTwo)
        controller.present(alertVC, animated: true, completion: nil)
    }
}
