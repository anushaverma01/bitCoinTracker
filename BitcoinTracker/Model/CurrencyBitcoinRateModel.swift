//
//  CurrencyBitcoinRateModel.swift
//  BitcoinTracker
//
//  Created by Anusha Verma on 13/07/21.
//

import Foundation

struct CoinDesk: Codable {
    var bpi =  Dictionary<String,Details>()
    private enum CodingKeys : String, CodingKey {
        case bpi = "bpi"
    }
}
struct Details: Codable {
    var code: String?
    var symbol: String?
    var rate: String?
    var description: String?
    var rate_float: Float?
    
    private enum CodingKeys : String, CodingKey {
        case code = "code"
        case symbol = "symbol"
        case rate = "rate"
        case description = "description"
        case rate_float = "rate_float"
    }
    
}
