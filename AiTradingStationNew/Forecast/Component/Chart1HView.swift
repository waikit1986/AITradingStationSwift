//
//  ChartView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI
import Charts

struct Chart1HView: View {

    let fcVM: ForecastVM

    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "HH:mm"
        return f
    }()

    // Visible chart size
    private let visibleHeight: CGFloat = 350
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
            } else if !fcVM.chart1HData.isEmpty {
                HStack {
                    Spacer()
                    Text("1H chart")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Chart
                            Chart {
                                // Area under line
                                ForEach(fcVM.chart1HData) { point in
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
                                ForEach(fcVM.chart1HData) { point in
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

                                // Points with annotation
                                ForEach(fcVM.chart1HData) { point in
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
                            .frame(width: CGFloat(fcVM.chart1HData.count) * pointSpacing + 50, height: visibleHeight)
                            .chartYScale(domain: yAxisDomain())
                            .chartYAxis(.hidden)
                            .chartXAxis(.hidden)
                            
                            // Custom timestamp labels below
                            HStack(spacing: 0) {
                                ForEach(fcVM.chart1HData) { point in
                                    Text(Self.timeFormatter.string(from: point.timestamp))
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
            fcVM.forecastSession = "hourly"
            await fcVM.fetch1hChart()
        }
    }

    private func yAxisDomain() -> ClosedRange<Double> {
        guard !fcVM.chart1HData.isEmpty else { return 0...1 }
        let minY = fcVM.chart1HData.map { $0.close }.min() ?? 0
        let maxY = fcVM.chart1HData.map { $0.close }.max() ?? 1
        let padding = (maxY - minY) * 0.1
        return (minY - padding)...(maxY + padding)
    }
}

#Preview {
    Chart1HView(fcVM: ForecastVM())
}
