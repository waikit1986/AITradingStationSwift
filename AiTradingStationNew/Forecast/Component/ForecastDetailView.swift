//
//  ForecastDetailView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastDetailView: View {
    let fcVM: ForecastVM
    
    var body: some View {
        ScrollView {
            if fcVM.isLoadingForecast {
                VStack {
                    ProgressView()
                    Text("Fetching forecast…")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding(.top, 40)
            } else if let f = fcVM.forecast {
                VStack(spacing: 24) {
                    // ------- Trading Signals -------
                    VStack {
                        VStack(alignment: .leading, spacing: 16) {
                            if fcVM.forecastSession == "hourly" {
                                VStack {
                                    Text("Hourly forecast: \(formatHour(f.timestamp))")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                    
                                    Text("*update on every 1 hour")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                            } else {
                                VStack {
                                    Text("Daily forecast for: \(formatShortDateWithDay(f.timestamp))")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("*update on every day at 8:05am")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                            }
                            
                            Text("Trading Signals")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Trade Signal")
                                        .font(.caption)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Text(f.trade_signal)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .trailing, spacing: 6) {
                                    Text("Directional Bias")
                                        .font(.caption)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Text(f.directional_bias)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Confidence")
                                        .font(.caption)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Text("\(f.confidence_score, specifier: "%.1f")%")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(alignment: .trailing, spacing: 6) {
                                    Text("Confidence Level")
                                        .font(.caption)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Text(f.confidence_level)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            VStack(spacing: 12) {
                                
                                HStack {
                                    Text("Entry Price")
                                        .font(.subheadline)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Spacer()
                                    Text("$\(f.entry_price, specifier: "%.2f")")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                }
                                
                                HStack {
                                    Text("Target Price")
                                        .font(.subheadline)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Spacer()
                                    Text("$\(f.target_price, specifier: "%.2f")")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.green)
                                }
                                
                                HStack {
                                    Text("Stop Loss")
                                        .font(.subheadline)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                    Spacer()
                                    Text("$\(f.stop_loss, specifier: "%.2f")")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.08))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.6), radius: 8, x: 0, y: 4)
                    
                    // ------- Market Analysis -------
                    VStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Market Analysis")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Outlook")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(f.outlook)
                                    .foregroundColor(Color.gray.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Key Drivers")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(f.key_drivers)
                                    .foregroundColor(Color.gray.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Macro Alignment")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(f.macro_alignment)
                                    .foregroundColor(Color.gray.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.08))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.6), radius: 8, x: 0, y: 4)
                    
                    // ------- Risk Management -------
                    VStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Risk Management")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Risk Signals")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(f.risk_signals)
                                    .foregroundColor(Color.gray.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Confirmation Trigger")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(f.confirmation_trigger)
                                    .foregroundColor(Color.gray.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Invalidation Level")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("$\(f.invalidation_level, specifier: "%.2f")")
                                    .foregroundColor(Color.gray.opacity(0.6))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.08))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.6), radius: 8, x: 0, y: 4)
                    
                    // ------- Timestamp -------
                    Text("Last updated: \(formatDate(f.timestamp))")
                        .font(.caption)
                        .foregroundColor(Color.gray.opacity(0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)
                    
                }
            } else if let error = fcVM.errorMessageForecast {
                Text("Error: Forecast:\n\(error)")
                    .foregroundColor(.purple)
                    .padding()
            }
        }
        .navigationTitle(fcVM.forecast?.symbol ?? "Forecast")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: fcVM.symbol) {
            await fcVM.fetchForecast()
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f.string(from: date)
    }
    
    private func formatHour(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:00a"  // Includes minutes
        return formatter.string(from: date).lowercased()  // "4:00pm"
    }
    
    private func formatShortDateWithDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter.string(from: date)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        ForecastDetailView(fcVM: ForecastVM())
    }
}

