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
    var errorMessageHeader: String?
    var errorMessageChart: String?
    var errorMessageForecast: String?
    var symbol: String? = "spy"
    var forecastSession: String? = "hourly"
    var headerLatestPrice: [MsDataApi] = []
    var chart15MinData: [MsDataApi] = []
    var chart1HData: [MsDataApi] = []
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
//    private let baseURL = URL(string: "https://264dbed18e8c.ngrok-free.app")!
    
    func fetchLatestHeaderPrice() async {
        errorMessageHeader = nil
        do {
            var components = URLComponents(
                url: baseURL.appendingPathComponent("/api/ms/15min"),
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
            headerLatestPrice = try decoder.decode([MsDataApi].self, from: data)
            
        } catch {
            errorMessageHeader = error.localizedDescription
        }
    }
    
    func fetch15minChart() async {
        errorMessageChart = nil
        isLoadingChart = true
        defer { isLoadingChart = false }
        
        do {
            var components = URLComponents(
                url: baseURL.appendingPathComponent("/api/ms/15min/chart"),
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
            chart15MinData = try decoder.decode([MsDataApi].self, from: data)
            
        } catch {
            errorMessageChart = error.localizedDescription
        }
    }
    
    func fetch1hChart() async {
        errorMessageChart = nil
        isLoadingChart = true
        defer { isLoadingChart = false }
        
        do {
            var components = URLComponents(
                url: baseURL.appendingPathComponent("/api/ms/1h/chart"),
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
            chart1HData = try decoder.decode([MsDataApi].self, from: data)
            
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

