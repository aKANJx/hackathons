//
//  GraphView.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 15/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI

struct GraphView: UIViewRepresentable {
        
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: .zero)
        let numberOfSets = 2
        for setIndex in 1...numberOfSets {
            graphView.dataSource = context.coordinator
            let line = LinePlot(identifier: "set\(setIndex)")
            let color = (setIndex == 1) ? UIColor(named: "base")! : UIColor(named: "sec")!
            line.lineWidth = 1
            line.lineColor = color
            line.lineStyle = .smooth
            line.shouldFill = true
            line.fillType = .solid
            line.fillColor = color.withAlphaComponent(0.5)
            line.adaptAnimationType = .elastic
            graphView.addPlot(plot: line)
        }
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.clear
        referenceLines.referenceLineLabelColor = UIColor.black
        referenceLines.dataPointLabelColor = UIColor.black.withAlphaComponent(1)
        // Setup the graph
        graphView.backgroundFillColor = UIColor.clear
        graphView.dataPointSpacing = 80
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.addReferenceLines(referenceLines: referenceLines)
        return graphView
    }
    
    func updateUIView(_ uiView: ScrollableGraphView, context: Context) { }
    
    class Coordinator: NSObject, ScrollableGraphViewDataSource {
        
        var set1: [Double] = [4,3,2,1,1,1,3,3,3,3,3,4,5]
        var set2: [Double] = [1,2,3,2,1,4,2,4,3,4,2,1,4]

        
        func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
            if plot.identifier == "set1" {
                return set1[pointIndex]
            }
            return set2[pointIndex]
        }
        
        func label(atIndex pointIndex: Int) -> String {
            return "OUT \(pointIndex+1)"
        }
        
        func numberOfPoints() -> Int {
            return set1.count
        }
    }
}


struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
