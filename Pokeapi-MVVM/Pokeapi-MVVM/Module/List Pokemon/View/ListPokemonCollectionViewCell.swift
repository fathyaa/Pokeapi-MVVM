//
//  ListCollectionViewCell.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit

class ListPokemonCollectionViewCell: UICollectionViewCell {

    static let identifier = "ListPokemonCollectionViewCell"
    @IBOutlet weak var pokeView: UIView!{
        didSet{
            pokeView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        }
    }
    @IBOutlet weak var labelView: UIView!{
        didSet{
            labelView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
