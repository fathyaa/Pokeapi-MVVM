//
//  ViewController.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import UIKit

class ListPokemonViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    var listPokemonViewModel: ListPokemonViewModel?
    var modelPokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        self.listPokemonViewModel = ListPokemonViewModel(urlString: "https://pokeapi.co/api/v2/pokemon", apiService: ApiSevice())
        
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
        guard let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: ListPokemonCollectionViewCell.identifier, for: indexPath) as? ListPokemonCollectionViewCell else { return UICollectionViewCell() }
        cell.nameLabel.text = modelPokemon?.results[indexPath.row].name
//        cell.pokemonPhoto.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.row+1).png"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 0.4, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
}

