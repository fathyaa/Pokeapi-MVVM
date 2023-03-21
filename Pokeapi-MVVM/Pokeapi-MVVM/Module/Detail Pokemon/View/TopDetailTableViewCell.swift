//
//  TopDetailTableViewCell.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit

class TopDetailTableViewCell: UITableViewCell {

    static let identifier = "TopDetailTableViewCell"
    @IBOutlet weak var topDetailView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!{
        didSet{
            pokemonImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var titleView: UIView!{
        didSet{
            titleView.roundCorners(corners: [.bottomLeft], radius: 30)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: DetailPokeModel){
        nameLabel.text = data.name
        statLabel.text = "\(data.hp) HP"
        pokemonImage.sd_setImage(with: URL(string: data.sprites.imageUrl))
    }
}
