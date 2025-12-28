//
//  HeaderView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct HeaderView: View {
    let vm: ViewModel
    
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.timeZone = TimeZone(identifier: "America/New_York")
        f.dateFormat = "dd/MM HH:mm"
        return f
    }()
    
    var body: some View {
        VStack {
            if vm.isLoadingHeader {
                ProgressView("Loading Latest Price...")
                    .foregroundColor(.white)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Menu {
                        ForEach(vm.symbolList, id: \.self) { sym in
                            Button(sym) {
                                Task {
                                    vm.symbol = sym
                                    await vm.fetchLatestHeaderPrice()
                                    await vm.fetchDailyChart()
                                    await vm.fetch15minChart()
                                    await vm.fetchForecast()
                                }
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Text((vm.forecastSession == "hourly" ? vm.headerLatestPrice.last?.symbol : vm.chartDailyData.last?.symbol) ?? "--")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Image(systemName: "chevron.down")
                                .font(.title3)
                                .opacity(0.7)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                    }
                    
                    Text(vm.headerLatestPrice.last?.symbol_name ?? "--")
                        .font(.title3)
                        .fontWeight(.thin)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        Text(String(format: "%.2f", vm.headerLatestPrice.last?.marketstack_last ?? 0))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                Task {
                                    await vm.fetchLatestHeaderPrice()
                                    await vm.fetchDailyChart()
                                    await vm.fetch15minChart()
                                    await vm.fetchForecast()
                                }
                            }
                    }
                    
                    Text("last updated derived data: \(vm.headerLatestPrice.last?.timestamp != nil ? Self.timeFormatter.string(from: vm.headerLatestPrice.last!.timestamp) : "--")")
                        .font(.caption2)
                        .fontWeight(.thin)
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            Task {
                await vm.fetchLatestHeaderPrice()
                await vm.fetchDailyChart()
                await vm.fetch15minChart()
            }
        }
    }
}

#Preview {
    HeaderView(vm: ViewModel())
}
