//
//  ForecastView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastView: View {
    let vm: ViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(vm: vm)
                    .padding()
                
                TabView {
                    ForecastDailyView(vm: vm)
                        .padding()
                        .tabItem {
                            Text("Daily\n Forecast")
                        }
                        .tag(0)
                    
                    ForecastHourlyView(vm: vm)
                        .padding()
                        .tabItem {
                            Text("Hourly\n Forecast")
                        }
                        .tag(1)
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "arrow.clockwise")
                        .padding()
                        .padding(.top)
                        .padding(.horizontal)
                        .font(.title)
                        .foregroundStyle(.blue)
                        .onTapGesture {
                            Task {
                                await vm.fetchLatestHeaderPrice()
                                await vm.fetchDailyChart()
                                await vm.fetch15minChart()
//                                if fcVM.forecastSession == "hourly" {
//                                    await fcVM.fetch15minChart()
//                                } else {
//                                    await fcVM.fetchDailyChart()
//                                }
                                
                                await vm.fetchForecast()
                            }
                        }
                }
            }

        }
    }
}

#Preview {
    ForecastView(vm: ViewModel())
        .preferredColorScheme(.dark)
}

