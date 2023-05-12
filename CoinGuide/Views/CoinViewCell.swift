//
//  CoinViewCell.swift
//  CoinGuide
//
//  Created by Рома Баранов on 12.05.2023.
//

import UIKit

final class CoinViewCell: UITableViewCell {
    @IBOutlet var photoView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func assignment(with coin: Coin) {
        nameLabel.text = coin.name
        priceLabel.text = String(round(coin.currentPrice * 1000) / 1000)
        
        networkManager.fetchImage(from: coin.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.photoView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
