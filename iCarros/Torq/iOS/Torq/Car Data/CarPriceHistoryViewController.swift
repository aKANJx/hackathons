//
//  CarPriceHistoryViewController.swift
//  Torq
//
//  Created by Felipe Antonio Cardoso on 21/10/2018.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Charts

class CarPriceHistoryViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var car: Car?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = car?.model
        self.setDataCount(12)
    }
    
    func setDataCount(_ count: Int) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let val = (i > 8) ? Double(35) : Double(36)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(36 - (36/(i+10)))
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: yVals1, label: "FIPE")
        set1.axisDependency = .left
        set1.setColor(UIColor.red)
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 1
        set1.drawFilledEnabled = false
        set1.highlightColor = UIColor.red
        set1.drawCircleHoleEnabled = false
        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMinimum)
        }
        
        let set2 = LineChartDataSet(entries: yVals2, label: "Seu veículo (avaliado pelo iCarros)")
        set2.axisDependency = .left
        set2.setColor(UIColor.green)
        set2.drawCirclesEnabled = false
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 1
        set2.drawFilledEnabled = false
        set2.highlightColor =  UIColor.green
        set2.drawCircleHoleEnabled = false
        set2.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMaximum)
        }
        
        let data = LineChartData(dataSets: [set1, set2])
        data.setDrawValues(false)
        
        chartView.data = data
    }
}
