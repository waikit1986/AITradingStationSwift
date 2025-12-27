//
//  Forecast10MinView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastHourlyView: View {
    let vm: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Chart15MinView(vm: vm)

            ForecastDetailView(vm: vm)
                .onAppear {
                    vm.forecastSession = "hourly"
                }
        }
    }
}

#Preview {
    ForecastHourlyView(vm: ViewModel())
}
