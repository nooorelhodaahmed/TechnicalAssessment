//
//  MoviesListTableViewCell.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel:UILabel!
    @IBOutlet weak var movieImageView:UIImageView!
    @IBOutlet weak var releaseDateLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
