//
//  ListPokemonViewModel.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import Foundation

protocol ListPokemonViewProtocol {
    var urlString: String { get }
    var bindListPokemonData: ((PokemonModel?) -> ())? { get set }
    func fetchPokemonDatas()
}

class ListPokemonViewModel: ListPokemonViewProtocol {
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var data: PokemonModel?
    
    var bindListPokemonData: ((PokemonModel?) -> Void)?
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        fetchPokemonDatas()
    }
    
    func fetchPokemonDatas() {
        self.apiService?.callApi(model: PokemonModel.self, completion: { response in
            switch response {
            case .success(let pokemonsData):
                print("success")
                self.data = pokemonsData
                let group = DispatchGroup()
                
                for (index, pokemon) in pokemonsData.results.enumerated() {
                    group.enter()
                    guard let url = URL(string: pokemon.url) else {
                        group.leave()
                        continue
                    }
                    self.apiService?.get(url: url)
                    self.apiService?.callApi(model: PokemonImageModel.self, completion: { response in
                        switch response {
                        case .success(let spritesModel):
                            self.data?.results[index].image = spritesModel
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                        group.leave()
                    })
                }
                
                group.notify(queue: DispatchQueue.main) {
                    self.bindListPokemonData?(self.data)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                self.bindListPokemonData?(nil)
            }
        })
    }
    
    
}
