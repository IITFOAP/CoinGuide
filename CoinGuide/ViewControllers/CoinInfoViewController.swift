//
//  CoinInfoViewController.swift
//  CoinGuide
//
//  Created by Рома Баранов on 12.05.2023.
//

import UIKit

final class CoinInfoViewController: UIViewController {
    // MARK: - IB Outlet

    @IBOutlet var coinImageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    
    // MARK: - Public Properties
    var coin: Coin!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Sycle
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
    
    
    @IBAction func closesTheScreen() {
        dismiss(animated: true)
    }
}
