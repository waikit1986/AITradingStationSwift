//
//  ForecastVM.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class ForecastVM {
    var isLoadingChart: Bool = false
    var isLoadingForecast: Bool = false
    var errorMessageChart: String?
    var errorMessageForecast: String?
    var symbol: String? = "spy"
    var forecastSession: String? = "hourly"
    var chart10MinData: [MsDataApi] = []
    var chartDailyData: [MsDataApi] = []
    var forecast: FcDb?
    
    let symbolList = [
        // 🟦 Core tradable ETFs
        "SPY", "QQQ", "DIA", "IWM",
        
        // 🟨 Sector ETFs
        "XLK", "XLF", "XLE", "XLV", "SMH", "SOXL",
        
        // 🟧 Commodities
        "GLD", "SLV", "USO",
    ]
    
    private let baseURL = URL(string: "https://aitradingstation.com")!
    
    func fetch10minChart() async {
        errorMessageChart = nil
        isLoadingChart = true
        defer { isLoadingChart = false }
        
        do {
            var components = URLComponents(
                url: baseURL.appendingPathComponent("/api/ms/10min/chart"),
                resolvingAgainstBaseURL: false
            )!
            
            components.queryItems = [
                URLQueryItem(name: "symbol", value: symbol)
            ]
            
            guard let url = components.url else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let http = response as? HTTPURLResponse,
                  (200...299).contains(http.statusCode)
            else { throw URLError(.badServerResponse) }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            chart10MinData = try decoder.decode([MsDataApi].self, from: data)
            
        } catch {
            errorMessageChart = error.localizedDescription
        }
    }
    
    func fetchDailyChart() async {
        errorMessageChart = nil
        isLoadingChart = true
        defer { isLoadingChart = false }
        
        do {
            var components = URLComponents(
                url: baseURL.appendingPathComponent("/api/ms/daily/chart"),
                resolvingAgainstBaseURL: false
            )!
            
            components.queryItems = [
                URLQueryItem(name: "symbol", value: symbol)
            ]
            
            guard let url = components.url else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let http = response as? HTTPURLResponse,
                  (200...299).contains(http.statusCode)
            else { throw URLError(.badServerResponse) }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            chartDailyData = try decoder.decode([MsDataApi].self, from: data)
            
        } catch {
            errorMessageChart = error.localizedDescription
        }
    }
    
    func fetchForecast() async {
        errorMessageForecast = nil
        isLoadingForecast = true
        forecast = nil
        defer { isLoadingForecast = false }
        
        do {
            var components = URLComponents(
                url: baseURL.appendingPathComponent("/api/fc"),
                resolvingAgainstBaseURL: false
            )!
            
            components.queryItems = [
                URLQueryItem(name: "symbol", value: symbol),
                URLQueryItem(name: "session", value: forecastSession)
            ]
            
            guard let url = components.url else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let http = response as? HTTPURLResponse,
                  (200...299).contains(http.statusCode)
            else { throw URLError(.badServerResponse) }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            forecast = try decoder.decode(FcDb.self, from: data)
        } catch {
            errorMessageForecast = error.localizedDescription
        }
    }
}

