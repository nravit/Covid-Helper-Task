//
//  ChartsViewController.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import UIKit

class ChartsViewController: UIViewController {
    
    enum CurrentType {
        case details , localStored
    }
    
    @IBOutlet weak var averageOfSevenDaysLabel: UILabel!
    @IBOutlet weak var chartContainerView: UIView!
    
    
    var mainTitle: String = "Details"
    var code: String = ""
    
    var currentType: CurrentType = .details
    var viewModel: ChartsPersistance? = ChartsPersistance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = mainTitle
        setViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.setMainChartData()
    }
    
    func setViews() {
        
        if currentType == .details {
            viewModel?.saveDataToCoreData(withCountryName: mainTitle, code: code , description: code)
        }
        
        chartContainerView.addSubview(viewModel?.lineChartView ?? UIView())
        
        NSLayoutConstraint.activate([
            viewModel!.lineChartView.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor) ,
            viewModel!.lineChartView.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor) ,
            viewModel!.lineChartView.topAnchor.constraint(equalTo: chartContainerView.topAnchor) ,
            viewModel!.lineChartView.bottomAnchor.constraint(equalTo: chartContainerView.bottomAnchor)
        ])
        
        var averageActive = Int()
        if (viewModel?.countriesDetailsCharts.map({$0.active ?? 1}).reduce(0, +) ?? 0) == 0 {
            averageActive = 0
        } else {
            averageActive = ((viewModel?.countriesDetailsCharts.map({$0.active ?? 1}).reduce(0, +) ?? 0) / (viewModel?.countriesDetailsCharts.count ?? 1))
        }
        
        var averageRecovered = Int()
        if (viewModel?.countriesDetailsCharts.map({$0.recovered ?? 1}).reduce(0, +) ?? 0) == 0 {
            averageRecovered = 0
        } else {
            averageRecovered = ((viewModel?.countriesDetailsCharts.map({$0.recovered ?? 1}).reduce(0, +) ?? 0) / (viewModel?.countriesDetailsCharts.count ?? 1))
        }
        
        var acerageDeaths = Int()
        if (viewModel?.countriesDetailsCharts.map({$0.deaths ?? 1}).reduce(0, +) ?? 0) == 0 {
            acerageDeaths = 0
        } else {
            acerageDeaths = ((viewModel?.countriesDetailsCharts.map({$0.deaths ?? 1}).reduce(0, +) ?? 0) / (viewModel?.countriesDetailsCharts.count ?? 1))
        }
                
        averageOfSevenDaysLabel.text = """
            Active Cases: \(averageActive)
            Recovered: \(averageRecovered)
            Deaths: \(acerageDeaths)
            """
    }
}
