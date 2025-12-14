//
//  ChartView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//


import SwiftUI
import Charts

struct Chart15MinView: View {
    
    let fcVM: ForecastVM
    
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "HH:mm"
        return f
    }()
    
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
            } else if !fcVM.chart15MinData.isEmpty {
                
                HStack {
                    Spacer()
                    Text("15min chart")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    // Y-axis labels
                    VStack {
                        ForEach(Array(stride(from: yAxisDomain().upperBound, through: yAxisDomain().lowerBound, by: -(yAxisDomain().upperBound - yAxisDomain().lowerBound)/5)), id: \.self) { value in
                            Spacer()
                            Text(String(format: "%.2f", value))
                                .foregroundColor(.white)
                                .font(.caption2)
                            Spacer()
                        }
                    }
                    .frame(width: 40)
                    
                    // Chart + X-axis
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            VStack(spacing: 0) {
                                Chart {
                                    // Area under line
                                    ForEach(fcVM.chart15MinData) { point in
                                        if let last = point.marketstack_last {
                                            AreaMark(
                                                x: .value("Time", point.timestamp),
                                                yStart: .value("Baseline", yAxisDomain().lowerBound),
                                                yEnd: .value("Close", last)
                                            )
                                            .interpolationMethod(.catmullRom)
                                            .foregroundStyle(
                                                LinearGradient(
                                                    colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.3), Color.clear],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                        }
                                    }
                                    
                                    // Main line + points + latest price annotation
                                    ForEach(fcVM.chart15MinData) { point in
                                        if let last = point.marketstack_last {
                                            LineMark(
                                                x: .value("Time", point.timestamp),
                                                y: .value("Close", last)
                                            )
                                            .interpolationMethod(.catmullRom)
                                            .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                                            .foregroundStyle(
                                                LinearGradient(colors: [Color.purple, Color.blue], startPoint: .leading, endPoint: .trailing)
                                            )
                                            
                                            PointMark(
                                                x: .value("Time", point.timestamp),
                                                y: .value("Close", last)
                                            )
                                            .foregroundStyle(Color.white)
                                            .symbolSize(30)
                                            .annotation(position: point == fcVM.chart15MinData.last ? .topTrailing : .top) {
                                                if point == fcVM.chart15MinData.last {
                                                    Text(String(format: "%.2f", last))
                                                        .font(.caption.monospacedDigit())
                                                        .foregroundColor(.white)
                                                        .padding(4)
                                                        .background(Color.black.opacity(0.8))
                                                        .cornerRadius(4)
                                                        .fixedSize()
                                                }
                                            }
                                        }
                                    }
                                    
                                    // Last price rule line
                                    if let last = fcVM.chart15MinData.last(where: { $0.marketstack_last != nil })?.marketstack_last {
                                        RuleMark(y: .value("Last Price", last))
                                            .foregroundStyle(.red)
                                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                                    }
                                }
                                .frame(width: CGFloat(fcVM.chart15MinData.count) * pointSpacing + 50, height: visibleHeight)
                                .chartYScale(domain: yAxisDomain())
                                .chartXAxis(.hidden)
                                
                                // X-axis labels
                                HStack(spacing: 0) {
                                    ForEach(fcVM.chart15MinData) { point in
                                        let minute = Calendar.current.component(.minute, from: point.timestamp)
                                        Text(Self.timeFormatter.string(from: point.timestamp))
                                            .font(.caption2.weight(minute == 0 ? .bold : .regular))
                                            .foregroundColor(minute == 0 ? .blue : .white.opacity(0.7))
                                            .frame(width: pointSpacing, alignment: .center)
                                    }
                                }
                                .offset(x: 25)
                            }
                            .id("chart-end")
                        }
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
        }
        .padding(.vertical)
        .task(id: fcVM.symbol) {
            fcVM.forecastSession = "hourly"
//            await fcVM.fetch15minChart()
        }
    }
    
    private func yAxisDomain() -> ClosedRange<Double> {
        let values = fcVM.chart15MinData.compactMap { $0.marketstack_last }
        guard let minY = values.min(), let maxY = values.max() else { return 0...1 }
        let padding = (maxY - minY) * 0.1
        return (minY - padding)...(maxY + padding)
    }
}

#Preview {
    Chart15MinView(fcVM: ForecastVM())
}
