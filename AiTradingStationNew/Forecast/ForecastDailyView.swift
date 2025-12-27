//
//  ForecastDailyView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastDailyView: View {
    let vm: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ChartDailyView(vm: vm)

            ForecastDetailView(vm: vm)
                .onAppear {
                    vm.forecastSession = "morning"
                }
        }
    }
}

#Preview {
    ForecastDailyView(vm: ViewModel())
}
