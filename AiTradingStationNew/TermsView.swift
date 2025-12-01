//
//  TermsView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 12/1/25.
//

import SwiftUI

struct TermsView: View {
    let homeVM: HomeVM
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("AI Forecasting Terms and Conditions")
                    .font(.title)
                    .fontWeight(.bold)
                
                ForEach(TermsAndConditionsModel.sections) { section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.title)
                            .font(.headline)
                        
                        Text(section.body)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                if homeVM.isShowingAiTerms == true {
                    Button(action: {
                        homeVM.isShowingAiTerms = false
                    }) {
                        Text("I Understand")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("AccentColor"))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.top, 20)
                }
            }
            .padding()
        }
    }
}

#Preview {
    TermsView(homeVM: HomeVM())
}
