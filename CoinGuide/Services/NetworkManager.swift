//
//  NetworkManager.swift
//  CoinGuide
//
//  Created by Рома Баранов on 12.05.2023.
//

import Foundation
import Alamofire


enum Link {
    case coinsURL
    
    var url: URL {
        switch self {
        case .coinsURL:
            return URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false")!
        }
    }
}


final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCoin(from url: URL, completion: @escaping(Result<[Coin], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponce in
                switch dataResponce.result {
                case .success(let meaning):
                    let coins = Coin.getCoin(from: meaning)
                    completion(.success(coins))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let dataImage):
                    completion(.success(dataImage))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
