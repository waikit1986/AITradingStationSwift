//
//  ChartDailyView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/30/25.
//

import SwiftUI
import Charts

struct ChartDailyView: View {
    let vm: ViewModel

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "MMM d"
        return f
    }()

    // Visible chart size
    private let visibleHeight: CGFloat = 300
    private let pointSpacing: CGFloat = 50

    var body: some View {
        VStack(alignment: .leading) {
            if vm.isLoadingChart {
                ProgressView("Loading Chart...")
                    .foregroundColor(.white)
            } else if let error = vm.errorMessageChart {
                Text("Error: \(error)")
                    .foregroundColor(.purple)
                    .padding()
            } else if !vm.chartDailyData.isEmpty {
                HStack {
                    Spacer()
                    Text("daily chart")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Chart
                            Chart {
                                // Area under line
                                ForEach(Array(vm.chartDailyData.enumerated()), id: \.element.id) { index, point in
                                    AreaMark(
                                        x: .value("Time", index),
                                        yStart: .value("Baseline", yAxisDomain().lowerBound),
                                        yEnd: .value("Close", point.close)
                                    )
                                    .interpolationMethod(.catmullRom)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [
                                                Color.purple.opacity(0.5),
                                                Color.blue.opacity(0.3),
                                                Color.clear
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                }

                                // Main line
                                ForEach(Array(vm.chartDailyData.enumerated()), id: \.element.id) { index, point in
                                    LineMark(
                                        x: .value("Time", index),
                                        y: .value("Close", point.close)
                                    )
                                    .interpolationMethod(.catmullRom)
                                    .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.purple, Color.blue],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                }
                                
                                if let lastClose = vm.chartDailyData.last?.close {
                                    RuleMark(y: .value("Last Price", lastClose))
                                        .foregroundStyle(.red)
                                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                                }

                                // Vertical dash lines from points to x-axis
                                ForEach(Array(vm.chartDailyData.enumerated()), id: \.element.id) { index, point in
                                    RuleMark(x: .value("Time", index))
                                        .foregroundStyle(Color.white.opacity(0.2))
                                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 4]))
                                }

                                // Points with annotation
                                ForEach(Array(vm.chartDailyData.enumerated()), id: \.element.id) { index, point in
                                    PointMark(
                                        x: .value("Time", index),
                                        y: .value("Close", point.close)
                                    )
                                    .foregroundStyle(Color.white)
                                    .symbolSize(30)
                                    .annotation(position: .top) {
                                        Text(String(format: "%.2f", point.close))
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .fixedSize()
                                    }
                                }
                            }
                            .frame(width: CGFloat(vm.chartDailyData.count) * pointSpacing, height: visibleHeight)
                            .chartYScale(domain: yAxisDomain())
                            .chartXScale(domain: -0.5...Double(vm.chartDailyData.count - 1) + 0.5)
                            .chartYAxis(.hidden)
                            .chartXAxis(.hidden)
                            
                            // Custom timestamp labels below
                            HStack(spacing: 0) {
                                ForEach(Array(vm.chartDailyData.enumerated()), id: \.element.id) { index, point in
                                    Text(Self.dateFormatter.string(from: point.timestamp))
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.7))
                                        .frame(width: pointSpacing, alignment: .center)
                                }
                            }
                        }
                        .id("chart-end")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: visibleHeight)
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation {
                                proxy.scrollTo("chart-end", anchor: .trailing)
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical)
        .task(id: vm.symbol) {
            vm.forecastSession = "morning"
        }
    }

    private func yAxisDomain() -> ClosedRange<Double> {
        guard !vm.chartDailyData.isEmpty else { return 0...1 }
        let minY = vm.chartDailyData.map { $0.close }.min() ?? 0
        let maxY = vm.chartDailyData.map { $0.close }.max() ?? 1
        let padding = (maxY - minY) * 0.1
        return (minY - padding)...(maxY + padding)
    }
}

#Preview {
    ChartDailyView(vm: ViewModel())
}
