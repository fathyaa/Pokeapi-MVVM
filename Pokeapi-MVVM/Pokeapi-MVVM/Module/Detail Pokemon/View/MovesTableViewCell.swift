//
//  MovesTableViewCell.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit

class MovesTableViewCell: UITableViewCell {

    static let identifier = "MovesTableViewCell"
    @IBOutlet weak var moveName: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var effectLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(moveData: MoveModel){
        
        moveName.text = moveData.name
        accuracyLabel.text = "+\(moveData.detail?.accuracy ?? 0)"
        effectLabel.text = moveData.detail?.effectString ?? ""
    }
    
}
