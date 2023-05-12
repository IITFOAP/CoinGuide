//
//  CoinInfoViewController.swift
//  CoinGuide
//
//  Created by Рома Баранов on 12.05.2023.
//

import UIKit

final class CoinInfoViewController: UIViewController {
    
    @IBOutlet var coinImageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    
    var coin: Coin!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = coin.description
        
        networkManager.fetchImage(from: coin.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.coinImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
