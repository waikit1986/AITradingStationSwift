//
//  HomeVM.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 12/1/25.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class HomeVM {
    var selection: Int = 0
    var isShowPaywall = false
    var isShowingAiTerms: Bool {
        get { UserDefaults.standard.bool(forKey: "isShowingAiTerms") }
        set { UserDefaults.standard.set(newValue, forKey: "isShowingAiTerms") }
    }
}
