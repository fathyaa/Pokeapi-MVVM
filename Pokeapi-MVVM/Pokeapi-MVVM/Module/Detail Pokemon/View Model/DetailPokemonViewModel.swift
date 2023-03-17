//
//  DetailPokemonViewModel.swift
//  Pokeapi-MVVM
//
//  Created by Phincon on 17/03/23.
//

import Foundation

protocol DetailPokemonViewProtocol {
    var urlString: String { get }
    var bindDetailPokemon: (((DetailPokeModel)?) -> ())? { get set }
    func fetchPokemonDetail()
}

class DetailPokemonViewModel: DetailPokemonViewProtocol {
    private var apiService: ApiServiceProtocol?
    var urlString: String
    var data: DetailPokeModel?
    
    var bindDetailPokemon: (((DetailPokeModel)?) -> ())?
    
    init(urlString: String, apiService: ApiServiceProtocol){
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString){
            self.apiService?.get(url: url)
        }
        fetchPokemonDetail()
    }
    
    func fetchPokemonDetail() {
        self.apiService?.callApi(model: DetailPokeModel.self, completion: { response in
            switch response {
            case .success(let detailData):
                self.bindDetailPokemon?(detailData)
            case .failure(let error):
                print(error.localizedDescription)
                self.bindDetailPokemon?(nil)
            }
        })
    }
}
