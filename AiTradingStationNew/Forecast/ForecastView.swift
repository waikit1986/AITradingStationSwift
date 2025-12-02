//
//  ForecastView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastView: View {
    let fcVM: ForecastVM
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(fcVM: fcVM)
                    .padding()
                
                TabView {
                    ForecastHourlyView(fcVM: fcVM)
                        .padding()
                        .tabItem {
                            Text("Hourly")
                        }
                        .tag(0)
                    
                    ForecastDailyView(fcVM: fcVM)
                        .padding()
                        .tabItem {
                            Text("Daily")
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
                                if fcVM.forecastSession == "hourly" {
                                    await fcVM.fetch10minChart()
                                } else {
                                    await fcVM.fetchDailyChart()
                                }
                                await fcVM.fetchForecast()
                            }
                        }
                }
            }

        }
    }
}

#Preview {
    ForecastView(fcVM: ForecastVM())
        .preferredColorScheme(.dark)
}

