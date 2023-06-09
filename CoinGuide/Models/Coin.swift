//
//  Coin.swift
//  CoinGuide
//
//  Created by Рома Баранов on 12.05.2023.
//

import Foundation


struct Coin: Decodable {
    let name: String
    let image: String
    let currentPrice: Double
    let marketСap: Double
    let high: Double
    let low: Double
    let lastUpdated: String
    
    var description: String {
        """
        Name: \(name)
        Price: \(currentPrice)
        Capitalization: \(marketСap)
        Max day: \(high)
        Min day: \(low)
        Last update: \(lastUpdated)
        """
    }
    
    
    init(name: String, image: String, currentPrice: Double, marketСap: Double, high: Double, low: Double, lastUpdated: String) {
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketСap = marketСap
        self.high = high
        self.low = low
        self.lastUpdated = lastUpdated
    }
    
    init(from coinData: [String: Any]) {
        name = coinData["name"] as? String ?? ""
        image = coinData["image"] as? String ?? ""
        currentPrice = coinData["current_price"] as? Double ?? 0
        marketСap = coinData["market_cap"] as? Double ?? 0
        high = coinData["high_24h"] as? Double ?? 0
        low = coinData["low_24h"] as? Double ?? 0
        lastUpdated = coinData["last_updated"] as? String ?? ""
    }
    
    static func getCoin(from meaning: Any) -> [Coin] {
        guard let coinsData = meaning as? [[String: Any]] else { return [] }
        return coinsData.map { Coin(from: $0) }
    }
    
    
}
