//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Alex on 26.10.2020.
//

import UIKit
import SDWebImageSVGCoder

class MainTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var loadActivity: UIActivityIndicatorView! {
        didSet {
            loadActivity.stopAnimating()
            loadActivity.hidesWhenStopped = true
        }
    }
    
    //MARK: - Propertis
    
    static let reuseID = "MainTableViewCell"
    
    //MARK: - LiveCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityNameLabel.text = "City"
        conditionLabel.text = "----"
        tempLabel.text = "--℃"
        iconImageView.image = nil
    }
    
    //MARK: - Metods
    
    func setWeather(model: MainViewModel) {
        cityNameLabel.text = model.cityName
        if let factWeather = model.weather?.fact {
            loadActivity.stopAnimating()
            conditionLabel.text = factWeather.condition
            tempLabel.text = factWeather.temp
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(factWeather.icon).svg")
            iconImageView.sd_setImage(with: url)
        } else if let _ = model.loadError {
            loadActivity.stopAnimating()
            conditionLabel.text = "error"
        } else {
            loadActivity.startAnimating()
        }
    }
}

