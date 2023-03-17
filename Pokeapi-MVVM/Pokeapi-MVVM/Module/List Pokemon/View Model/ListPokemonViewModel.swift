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
            case .success(let success):
                print("success")
                self.bindListPokemonData?(success)
            case .failure(_):
                print("fail")
                self.bindListPokemonData?(nil)
            }
        })
    }
}
