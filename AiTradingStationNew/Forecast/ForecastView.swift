//
//  ForecastView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastView: View {
    let vm: ViewModel
    let reviewVM: ReviewVM
    
    var body: some View {
        VStack {
            TabView {
                VStack {
                    HeaderView(vm: vm)
                    ForecastDailyView(vm: vm)
                }
                .padding()
                .tabItem { Text("Daily") }
                .tag(0)
                
                VStack {
                    HeaderView(vm: vm)
                    ForecastHourlyView(vm: vm)
                }
                .padding()
                .tabItem { Text("Hourly") }
                .tag(1)
                
                SettingsView(vm: vm, reviewVM: reviewVM)
                    .padding()
                    .tabItem { Text("Settings") }
                    .tag(2)
            }
        }
    }
}

#Preview {
    ForecastView(vm: ViewModel(), reviewVM: ReviewVM())
        .preferredColorScheme(.dark)
}

