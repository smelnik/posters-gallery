//
//  PosterCell.swift
//  posters-gallery
//
//  Created by Developer on 3/30/17.
//  Copyright © 2017 Sergey Melnik (smelnik.means.me@gmail.com). All rights reserved.
//

import UIKit

class PosterCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageViewWidthConstraint: NSLayoutConstraint!
}
