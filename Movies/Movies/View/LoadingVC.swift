//
//  LoadingVC.swift
//  Movies
//
//  Created by Григорий Виняр on 23.06.2021.
//

import UIKit

class LoadingVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        animate()
    }

    func animate() {
        
            UIView.animate(withDuration: 3, animations: {
                self.logoImageView.transform = CGAffineTransform(scaleX: 8, y: 8)
                
            }) { _ in
                UIView.animate(withDuration: 3, animations: {
                    self.logoImageView.alpha = 0
                    LoadingViewModel().presentMainController(controller: self)
                })
            }
            
        }
    
}
