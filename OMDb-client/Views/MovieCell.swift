//
//  MovieCell.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var plotLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!

    func setupDescriptionFrom(_ item: OMDbItem) {
        titleLabel.text = item.title
        yearLabel.text = item.year
        plotLabel.text = item.plot
    }

    func setupPosterFrom(_ image: UIImage) {
        posterImageView.image = image
    }

}
