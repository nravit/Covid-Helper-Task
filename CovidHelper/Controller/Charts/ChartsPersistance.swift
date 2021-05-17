//
//  ChartsPersistance.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation
import UIKit
import Charts

class ChartsPersistance: BaseAPI {
    var countriesDetails: [CountriesDetails] = []
    var countriesDetailsCharts: [CountryCharts] = []
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.xAxis.gridColor = .clear
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.granularityEnabled = true
        chartView.backgroundColor = .clear
        return chartView
    }()
    
    func setMainChartData() {
        let data = LineChartData()
        let mainDD = setChartData()
        for dat in  mainDD {
            data.addDataSet(dat)
        }
        lineChartView.data = data
        lineChartView.animate(yAxisDuration: 0.5, easingOption: .easeInOutQuart)
    }
    
    private func setChartData() -> [LineChartDataSet] {
        var chardDataSet = [LineChartDataSet]()
        let line1 = LineChartDataSet(entries: getChartDataActive(wiwthHeartData: self.countriesDetailsCharts), label: "\("Active Cases")")
        line1.circleHoleColor = .yellow
        line1.colors = [.yellow]
        line1.circleColors = [.yellow]
        line1.mode = .linear
        line1.drawFilledEnabled = false
        line1.circleRadius = 5
        
        let line2 = LineChartDataSet(entries: getChartDataDeath(wiwthHeartData: self.countriesDetailsCharts), label: "\("Deaths")")
        line2.circleHoleColor = .red
        line2.circleColors = [.red]
        line2.colors = [.red]
        line2.mode = .linear
        line2.drawFilledEnabled = false
        line2.circleRadius = 5
        
        let line3 = LineChartDataSet(entries: getChartDataRecovered(wiwthHeartData: self.countriesDetailsCharts), label: "\("Recovered")")
        line3.circleHoleColor = .green
        line3.circleColors = [.green]
        line3.colors = [.green]
        line3.mode = .linear
        line3.drawFilledEnabled = false
        line3.circleRadius = 5
        
        chardDataSet.append(line1)
        chardDataSet.append(line2)
        chardDataSet.append(line3)
        
        return chardDataSet
    }
    
    private func getChartDataActive(wiwthHeartData: [CountryCharts]) -> [ChartDataEntry] {
        var lineChartEntry: [ChartDataEntry] = []
        for i in 0..<wiwthHeartData.count {
            lineChartEntry.append(ChartDataEntry(x: Double(i), y: Double(wiwthHeartData[i].active ?? 0)))
        }
        return lineChartEntry
    }
    
    private func getChartDataDeath(wiwthHeartData: [CountryCharts]) -> [ChartDataEntry] {
        var lineChartEntry: [ChartDataEntry] = []
        for i in 0..<wiwthHeartData.count {
            lineChartEntry.append(ChartDataEntry(x: Double(i), y: Double(wiwthHeartData[i].deaths ?? 0)))
        }
        return lineChartEntry
    }
    
    private func getChartDataRecovered(wiwthHeartData: [CountryCharts]) -> [ChartDataEntry] {
        var lineChartEntry: [ChartDataEntry] = []
        for i in 0..<wiwthHeartData.count {
            lineChartEntry.append(ChartDataEntry(x: Double(i), y: Double(wiwthHeartData[i].recovered ?? 0)))
        }
        return lineChartEntry
    }
    
    func saveDataToCoreData(withCountryName name: String , code: String , description: String) {
        let mainCountry = Country(context: CoreDataDataHelper.instance!.mainContaxt)
        mainCountry.country = name
        mainCountry.countryDescription = description
        mainCountry.countryCode = code
        
        var mainCountryDetails = [CountriesDetails]()
        
        for minCountry in countriesDetailsCharts {
            let count = CountriesDetails(context: CoreDataDataHelper.instance!.mainContaxt)
            count.active = Int32(minCountry.active ?? 0)
            count.deaths = Int32(minCountry.deaths ?? 0)
            count.recovered = Int32(minCountry.recovered ?? 0)
            count.country = minCountry.country ?? ""
            count.countryCode = minCountry.countryCode ?? ""
            count.date = minCountry.date ?? ""
            count.status = "confirmed"
            mainCountryDetails.append(count)
        }
        
        mainCountry.details = NSSet(array: mainCountryDetails)
        CoreDataDataHelper.instance?.saveContext()
    }
    

}
