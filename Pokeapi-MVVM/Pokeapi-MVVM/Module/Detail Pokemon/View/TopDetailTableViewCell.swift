//
//  TopDetailTableViewCell.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit

class TopDetailTableViewCell: UITableViewCell {

    static let identifier = "TopDetailTableViewCell"
    @IBOutlet weak var pokemonImage: UIImageView!{
        didSet{
            pokemonImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
