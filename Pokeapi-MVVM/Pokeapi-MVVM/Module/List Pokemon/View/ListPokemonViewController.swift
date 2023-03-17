//
//  ViewController.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit
import SDWebImage

class ListPokemonViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    var listPokemonViewModel: ListPokemonViewModel?
    var modelPokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PokeDex"
        setupCollectionView()
        
        self.listPokemonViewModel = ListPokemonViewModel(urlString: "https://pokeapi.co/api/v2/pokemon", apiService: ApiService())
        
        self.listPokemonViewModel?.bindListPokemonData = { pokeModel in
            if let model = pokeModel {
                self.modelPokemon = model
            } else {
                self.listCollectionView.backgroundColor = .red
            }
            print("reload data")
            DispatchQueue.main.async {
                self.listCollectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(UINib(nibName: "ListPokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListPokemonCollectionViewCell.identifier)
    }
}

extension ListPokemonViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.modelPokemon?.results.count ?? 0
        print("count ", count)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemon = modelPokemon?.results[indexPath.row],
            let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: ListPokemonCollectionViewCell.identifier, for: indexPath) as? ListPokemonCollectionViewCell else { return UICollectionViewCell() }
        cell.nameLabel.text = pokemon.name
        if let imageUrl = pokemon.image?.sprites.imageUrl {
            cell.pokemonPhoto.sd_setImage(with: URL(string: imageUrl))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 1.2, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let pokeData = modelPokemon?.results[indexPath.row],
           let detailVC = storyboard.instantiateViewController(withIdentifier: DetailPokemonViewController.identifier) as? DetailPokemonViewController {
            
            detailVC.detailUrl = pokeData.url
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

