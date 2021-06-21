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
            nameLabel.text = viewModel.name
            overviewLabel.text = viewModel.overview
            photoImageView.load(imageFrom: viewModel.photo)
            photoImageView.layer.cornerRadius = 41.5
            photoImageView.layer.borderWidth = 2
            photoImageView.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0))
        self.contentView.layer.cornerRadius = 13

        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 3
    }
}
