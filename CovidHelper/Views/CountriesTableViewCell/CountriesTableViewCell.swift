//
//  CountriesTableViewCell.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import UIKit
import ADCountryPicker

class CountriesTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBackView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    var countryPicker = ADCountryPicker()
    
    var country: Countrys? {
        didSet {
            countryNameLabel.text = country?.country ?? ""
            descriptionLabel.text = country?.iso2 ?? ""
            flagImageView.image = countryPicker.getFlag(countryCode: country?.iso2 ?? "IN")
            mainBackView.layer.cornerRadius = 8
            mainBackView.dropShadow()
        }
    }
    
    var maincountry: Country? {
        didSet {
            countryNameLabel.text = maincountry?.country ?? ""
            descriptionLabel.text = maincountry?.countryCode ?? ""
            flagImageView.image = countryPicker.getFlag(countryCode: maincountry?.countryCode ?? "IN")
            mainBackView.layer.cornerRadius = 8
            mainBackView.dropShadow()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func loadNib() -> UINib? {
        UINib(nibName: "CountriesTableViewCell", bundle: .main)
    }

}


extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}
