//
//  RegistrationViewModel.swift
//  Movies
//
//  Created by Григорий Виняр on 04.06.2021.
//

import Foundation

class RegistrationViewModel {
    
    private var titleLabel: String
    
    var title: String {
        return titleLabel
    }
    
    init(title: String) {
        self.titleLabel = title
    }
}
