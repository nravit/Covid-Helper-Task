//
//  LocalyStoredViewController.swift
//  CovidHelper
//
//  Created by Raviteja on 16/05/21.
//

import UIKit

class LocalyStoredViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    var viewModel: LocallyStoredPersistance? = LocallyStoredPersistance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchStoredData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Locally Stored"
    }
    
    func setViews() {
        
        mainTableView.register(CountriesTableViewCell.loadNib(), forCellReuseIdentifier: "CountriesTableViewCell")
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainSearchBar.delegate = self
        
        
    }
    
    func fetchStoredData() {
        viewModel?.fetchFromCoreData(completion: { [weak self] isSuccess, message in
            if isSuccess {
                self?.mainTableView.reloadData()
            } else {
                self?.showDefaultAlert(Message: message)
            }
        })
    }
}

extension LocalyStoredViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.country?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesTableViewCell") as! CountriesTableViewCell
        cell.maincountry = viewModel?.country?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChartsViewController") as! ChartsViewController
        vc.currentType = .localStored
        vc.mainTitle = viewModel?.country?[indexPath.row].country ?? "" ?? ""
        
        vc.viewModel?.countriesDetailsCharts = (Array((viewModel?.country?[indexPath.row].details ?? [])) as? [CountriesDetails] ?? []).map({CountryCharts(country: $0.country, countryCode: $0.countryCode, lat: $0.lat, lon: $0.lon, confirmed: Int($0.confirmed), deaths: Int($0.deaths), recovered: Int($0.recovered), active: Int($0.active), date: $0.date, locationID: $0.countryCode)}) ?? []
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension LocalyStoredViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(withText: searchText)
        mainTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.search(withText: "")
        mainTableView.reloadData()
    }
}

