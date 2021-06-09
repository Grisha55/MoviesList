//
//  MovieCell.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit
import SDWebImage

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
            
            let imageView = UIImageView()
            
            imageView.sd_setImage(with: URL(string: viewModel.photoString), placeholderImage: UIImage(systemName: "person.3"))
            self.photoImageView.image = imageView.image
            
        }
    }
    
    @IBAction func buttonLikeAction(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.likeAction()
    }
}
