//
//  CoinListViewController.swift
//  CoinGuide
//
//  Created by Рома Баранов on 12.05.2023.
//

import UIKit


final class CoinListViewController: UITableViewController {
    // MARK: - Private Properties
    private var coins: [Coin] = []
    private let networkMahager = NetworkManager.shared
    
    // MARK: - View Life Sycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoin()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinList", for: indexPath)
        guard let cell = cell as? CoinViewCell else { return UITableViewCell() }
        let coin = coins[indexPath.row]
        cell.assignment(with: coin)
        tableView.rowHeight = 50
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPatch = tableView.indexPathForSelectedRow {
            guard let coinInfoVC = segue.destination as? CoinInfoViewController else { return }
            coinInfoVC.coin = coins[indexPatch.row]
        }
    }
    // MARK: - Private Methods
    private func fetchCoin() {
        networkMahager.fetchCoin(from: Link.coinsURL.url) { [weak self] result in
            switch result {
            case .success(let coin):
                self?.coins = coin
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
