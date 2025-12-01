//
//  ForecastModel.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import Foundation

struct MsDataApi: Codable, Identifiable {
    var id: String { "\(symbol)-\(timestamp.timeIntervalSince1970)" }

    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Double?
    let symbol: String
    let symbol_name: String
    let timestamp: Date
}

struct FcDb: Codable, Identifiable {
    var id: String { "\(symbol)-\(timestamp.timeIntervalSince1970)" }
    
    let symbol: String
    let timestamp: Date
    
    let trade_signal: String
    let directional_bias: String
    let entry_price: Double
    let target_price: Double
    let stop_loss: Double
    let confidence_score: Double
    let confidence_level: String
    
    let outlook: String
    let key_drivers: String
    let macro_alignment: String
    
    let risk_signals: String
    let confirmation_trigger: String
    let invalidation_level: Double
}

