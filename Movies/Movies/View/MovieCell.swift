//
//  MovieCell.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import Firebase

class MovieCell: UITableViewCell {
    
    let urlForImage = "https://image.tmdb.org/t/p/w300"
    
    //MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    var viewModel: MovieCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            overviewLabel.text = viewModel.overview
            photoImageView.load(imageFrom: viewModel.photoString)
            photoImageView.layer.cornerRadius = 20
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        
    }
}
