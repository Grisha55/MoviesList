//
//  Transitions.swift
//  Movies
//
//  Created by Григорий Виняр on 10.06.2021.
//

import UIKit

class Transitions {
    
    func showModalAuth(controller: UIViewController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let new = storyboard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        guard let controller = controller else { return }
        controller.present(new, animated: true, completion: nil)
    }
}
