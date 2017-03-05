//
//  StatisticsViewController.swift
//  Rate Us
//
//  Created by Khant Zaw Ko on 4/3/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Charts
import FirebaseDatabase

class StatisticsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var barChartView: BarChartView!
    
    var ref: FIRDatabaseReference!
    
//    let months = ["Jan", "Feb", "Mar", "Apr"]
//    let excellent = [20.0, 4.0, 6.0, 3.0]
//    let good = [5.0, 14.0, 20.0, 13.0]
//    let average = [10.0, 34.0, 40.0, 23.0]
//    let bad = [15.0, 24.0, 37.0, 43.0]
//    let terrible = [25.0, 4.0, 10.0, 27.0]

    let months = ["March"]
    var excellent = [0.0]
    var good = [0.0]
    var average = [0.0]
    var bad = [0.0]
    var terrible = [0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.chartDescription?.text = ""
        
        let xaxis = barChartView.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.5
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        barChartView.rightAxis.enabled = false
        
        getRatingStats()
        
        backButton.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
    }
    
    func getRatingStats() {
        
        ref = FIRDatabase.database().reference().child("the-testing-one")
        
        ref.observe(.childAdded, with: {(snapshot: FIRDataSnapshot) in
            var value = snapshot.value as! [String : AnyObject]
            
            if snapshot.key == "Excellent" {
                self.excellent[0] = Double(snapshot.childSnapshot(forPath: "Mar 05 2017").childrenCount)
            } else if snapshot.key == "Good" {
                self.good[0] = Double(snapshot.childSnapshot(forPath: "Mar 05 2017").childrenCount)
            } else if snapshot.key == "Average" {
                self.average[0] = Double(snapshot.childSnapshot(forPath: "Mar 05 2017").childrenCount)
            } else if snapshot.key == "Bad" {
                self.bad[0] = Double(snapshot.childSnapshot(forPath: "Mar 05 2017").childrenCount)
            } else if snapshot.key == "Terrible" {
                self.terrible[0] = Double(snapshot.childSnapshot(forPath: "Mar 05 2017").childrenCount)
            } else {
                print("error")
            }
            
            self.setChart()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //ref
    }

    func setChart() {
        var dataEntries1: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        var dataEntries3: [BarChartDataEntry] = []
        var dataEntries4: [BarChartDataEntry] = []
        var dataEntries5: [BarChartDataEntry] = []
        
        for i in 0..<self.months.count {
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: excellent[i])
            dataEntries1.append(dataEntry1)
            
            let dataEntry2 = BarChartDataEntry(x: Double(i) , y: good[i])
            dataEntries2.append(dataEntry2)
            
            let dataEntry3 = BarChartDataEntry(x: Double(i) , y: average[i])
            dataEntries3.append(dataEntry3)
            
            let dataEntry4 = BarChartDataEntry(x: Double(i) , y: bad[i])
            dataEntries4.append(dataEntry4)
            
            let dataEntry5 = BarChartDataEntry(x: Double(i) , y: terrible[i])
            dataEntries5.append(dataEntry5)
        }
        
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "Excellent")
        let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "Good")
        let chartDataSet3 = BarChartDataSet(values: dataEntries3, label: "Average")
        let chartDataSet4 = BarChartDataSet(values: dataEntries4, label: "Bad")
        let chartDataSet5 = BarChartDataSet(values: dataEntries5, label: "Terrible")

        let dataSets: [BarChartDataSet] = [chartDataSet1, chartDataSet2, chartDataSet3, chartDataSet4, chartDataSet5]
        chartDataSet1.colors = [UIColor.green]
        chartDataSet2.colors = [UIColor.cyan]
        chartDataSet3.colors = [UIColor.yellow]
        chartDataSet4.colors = [UIColor.orange]
        chartDataSet5.colors = [UIColor.red]

        
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.25
        let barSpace = 0.05
        let barWidth = 0.1
        // (0.1 + 0.05) * 5 + 0.25 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        let startYear = 0
        
        
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()
        
        barChartView.data = chartData

        //chart animation
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInBounce)
    }
    
    func pressButton(button: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
