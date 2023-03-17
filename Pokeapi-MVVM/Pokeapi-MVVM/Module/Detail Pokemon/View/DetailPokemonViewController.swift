//
//  DetailPokemonViewController.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit

class DetailPokemonViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    static let identifier = "DetailPokemonViewController"
    var detailUrl: String?
    var detailViewModel: DetailPokemonViewModel?
    var modelDetail: DetailPokeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        setupTableView()
        
        guard let detailUrl = detailUrl else { return }
        self.detailViewModel = DetailPokemonViewModel(urlString: detailUrl, apiService: ApiService())
        self.detailViewModel?.bindDetailPokemon = { detailModel in
            if let model = detailModel {
                self.modelDetail = model
            } else {
                self.detailTableView.backgroundColor = .red
            }
        }
    }

    func setupTableView(){
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(UINib(nibName: "TopDetailTableViewCell", bundle: nil), forCellReuseIdentifier: TopDetailTableViewCell.identifier)
        detailTableView.register(UINib(nibName: "MovesTableViewCell", bundle: nil), forCellReuseIdentifier: MovesTableViewCell.identifier)
    }
}

extension DetailPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return modelDetail?.moves.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        guard let imageData = modelDetail?.sprites.imageUrl,
              let cell = detailTableView.dequeueReusableCell(withIdentifier: "TopDetailTableViewCell", for: indexPath) as? TopDetailTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = modelDetail?.name
        cell.pokemonImage.sd_setImage(with: URL(string: imageData))
        return cell
        } else {
            guard let cell = detailTableView.dequeueReusableCell(withIdentifier: "MovesTableViewCell", for: indexPath) as? MovesTableViewCell else { return UITableViewCell() }
            cell.moveName.text = modelDetail?.moves[indexPath.row].move.name
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
