//
//  PrivacyPolicyView.swift
//  aitradingstation
//
//  Created by Low Wai Kit on 9/21/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    let policy = PrivacyPolicyModel.full
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Header
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Last updated \(policy.lastUpdated)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Text("App: \(policy.appName)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                // Table of contents
                VStack(alignment: .leading, spacing: 8) {
                    Text("Table of contents")
                        .font(.headline)
                    ForEach(policy.tableOfContents, id: \.self) { item in
                        Text(item)
                            .font(.subheadline)
                            .foregroundColor(.teal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                // Sections
                ForEach(policy.sections) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(section.title)
                            .font(.headline)
                        
                        if let summary = section.summary {
                            Text(summary)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        
                        ForEach(section.bullets, id: \.self) { b in
                            HStack(alignment: .top, spacing: 6) {
                                Text("•")
                                Text(b)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        
                        ForEach(section.extraText, id: \.self) { extra in
                            Text(extra)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        if let table = section.table {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(0..<table.count, id: \.self) { rowIndex in
                                    HStack {
                                        ForEach(table[rowIndex], id: \.self) { cell in
                                            Text(cell)
                                                .font(.footnote)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(6)
                                    .background(rowIndex == 0 ? Color.gray.opacity(0.1) : Color.clear)
                                    Divider()
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                        }
                    }
                }
                
                // Footer
                Text("Last updated: \(policy.lastUpdated)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    PrivacyPolicyView()
}

