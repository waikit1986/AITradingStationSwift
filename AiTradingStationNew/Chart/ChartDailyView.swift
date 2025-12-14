//
//  ChartHourlyView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/30/25.
//

import SwiftUI
import Charts

struct ChartDailyView: View {
    let fcVM: ForecastVM

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
            if fcVM.isLoadingChart {
                ProgressView("Loading Chart...")
                    .foregroundColor(.white)
            } else if let error = fcVM.errorMessageChart {
                Text("Error: \(error)")
                    .foregroundColor(.purple)
                    .padding()
            } else if !fcVM.chartDailyData.isEmpty {
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
                                ForEach(fcVM.chartDailyData) { point in
                                    AreaMark(
                                        x: .value("Time", point.timestamp),
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
                                ForEach(fcVM.chartDailyData) { point in
                                    LineMark(
                                        x: .value("Time", point.timestamp),
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
                                
                                if let lastClose = fcVM.chartDailyData.last?.close {
                                    RuleMark(y: .value("Last Price", lastClose))
                                        .foregroundStyle(.red)
                                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                                }

                                // Points with annotation
                                ForEach(fcVM.chartDailyData) { point in
                                    PointMark(
                                        x: .value("Time", point.timestamp),
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
                            .frame(width: CGFloat(fcVM.chartDailyData.count) * pointSpacing + 50, height: visibleHeight)
                            .chartYScale(domain: yAxisDomain())
                            .chartYAxis(.hidden)
                            .chartXAxis(.hidden)
                            
                            // Custom timestamp labels below
                            HStack(spacing: 0) {
                                ForEach(fcVM.chartDailyData) { point in
                                    Text(Self.dateFormatter.string(from: point.timestamp))
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.7))
                                        .frame(width: pointSpacing, alignment: .center)
                                }
                            }
                            .offset(x: 25)
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
        .task(id: fcVM.symbol) {
            fcVM.forecastSession = "morning"
//            await fcVM.fetchDailyChart()
//            await fcVM.fetch15minChart()
        }
    }

    private func yAxisDomain() -> ClosedRange<Double> {
        guard !fcVM.chartDailyData.isEmpty else { return 0...1 }
        let minY = fcVM.chartDailyData.map { $0.close }.min() ?? 0
        let maxY = fcVM.chartDailyData.map { $0.close }.max() ?? 1
        let padding = (maxY - minY) * 0.1
        return (minY - padding)...(maxY + padding)
    }
}

#Preview {
    ChartDailyView(fcVM: ForecastVM())
}
