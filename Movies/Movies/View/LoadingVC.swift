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
                let size = self.view.frame.size.width * 10
                let difX = size - self.view.frame.size.width
                let diffY = self.view.frame.size.height - size
                self.logoImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.logoImageView.frame = CGRect(x: -(difX/2), y: diffY/2, width: size, height: size)
            }) { _ in
                UIView.animate(withDuration: 2, animations: {
                    self.logoImageView.alpha = 0
                    self.logoImageView.tintColor = .black
                    LoadingViewModel().presentMainController(controller: self)
                })
            }
            
        }
    
}
