//
//  CountriesListViewController.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import UIKit

class CountriesListViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    var viewModel: CountriesPersistance? = CountriesPersistance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        getCountries()
    }
    
    func setViews() {
        
        navigationItem.title = "Countries"
        
        mainTableView.register(CountriesTableViewCell.loadNib(), forCellReuseIdentifier: "CountriesTableViewCell")
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainSearchBar.delegate = self
    }
    
    func getCountries() {
        Indicator.shared.show(uiView: self.view)
        viewModel?.getCountriesList(completion: { isSuccess, message in
            Indicator.shared.hide(uiView: self.view)
            if isSuccess {
                self.mainTableView.reloadData()
            } else {
                self.showDefaultAlert(Message: message)
            }
        })
    }
    
    func getCountriesDetails(withSlug slug: String , name: String , iso: String) {
        Indicator.shared.show(uiView: self.view)
        viewModel?.getCountriesDetails(withSlug: slug, completion: { [weak self] isSuccess, message in
            guard let self = self else { return }
            Indicator.shared.hide(uiView: self.view)
            if isSuccess {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChartsViewController") as! ChartsViewController
                vc.mainTitle = name
                vc.code = iso
                vc.viewModel?.countriesDetailsCharts = self.viewModel?.countryDetails ?? []
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showDefaultAlert(Message: message)
            }
        })
    }
    
    
}

extension CountriesListViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.country?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesTableViewCell") as! CountriesTableViewCell
        cell.country = viewModel?.country?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getCountriesDetails(withSlug: viewModel?.country?[indexPath.row].slug ?? "" , name: viewModel?.country?[indexPath.row].country ?? "", iso: viewModel?.country?[indexPath.row].iso2 ?? "")
    }
}


extension CountriesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(withText: searchText)
        mainTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.search(withText: "")
        mainTableView.reloadData()
    }
}
