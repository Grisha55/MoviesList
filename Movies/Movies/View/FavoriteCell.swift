//
//  FavoriteCell.swift
//  Movies
//
//  Created by Григорий Виняр on 03.06.2021.
//

import UIKit

class FavoriteCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    weak var favoriteCellViewModel: FavoriteCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            photoImageView.image = viewModel.photo.image
            nameLabel.text = viewModel.name
            overviewLabel.text = viewModel.overview
        }
    }
}
