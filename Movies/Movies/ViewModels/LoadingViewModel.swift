//
//  LoadingViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 23.06.2021.
//

import UIKit

class LoadingViewModel {
    
    func presentMainController(controller: LoadingVC) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(identifier: "tabBarVC")
            tabBarVC.modalTransitionStyle = .flipHorizontal
            tabBarVC.modalPresentationStyle = .fullScreen
            controller.present(tabBarVC, animated: true, completion: nil)
        }
    }
}
