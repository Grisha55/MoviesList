//
//  MovieCell.swift
//  Movies
//
//  Created by Григорий Виняр on 02.06.2021.
//

import UIKit

class MovieCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    weak var viewModel: MovieCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            overviewLabel.text = viewModel.overview
            
            guard let url = URL(string: viewModel.photoString) else { return }
            
            guard let data = try? Data(contentsOf: url) else { return }
            
            photoImageView = UIImageView(image: UIImage(data: data))
        }
    }
    
}
