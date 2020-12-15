//
//  DetailViewController.swift
//  Weather
//
//  Created by Alex on 30.10.2020.
//

import UIKit
import SDWebImageSVGCoder

protocol DetailViewProtocol: class {
    func showCity(weatherModel: DetailWeatherViewModel)
}

class DetailViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var partName1Label: UILabel!
    @IBOutlet weak var tempMinMax1Label: UILabel!
    @IBOutlet weak var condition1Label: UILabel!
    @IBOutlet weak var windSpeedDir1Label: UILabel!
    
    @IBOutlet weak var partName2Label: UILabel!
    @IBOutlet weak var tempMinMax3Label: UILabel!
    @IBOutlet weak var condition2Label: UILabel!
    @IBOutlet weak var windSpeedDir2Label: UILabel!
    
    //MARK: - Variables
    
    private let presenter: DetailPresenterProtocol
    
    //MARK: - Init
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.start()
    }
    
    //MARK: - Metods
    
    private func setupUI() {
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .done, target: self, action: #selector(mapButtonPress))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc
    private func mapButtonPress() {
        presenter.mapButtonPress()
    }
}

//MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func showCity(weatherModel: DetailWeatherViewModel) {
        title = weatherModel.cityName
        cityNameLabel.text = weatherModel.cityName
        iconImageView.image = UIImage(systemName: "smiley")
        if let factWeather = weatherModel.fact {
            temperaturaLabel.text = factWeather.temp
            conditionLabel.text = factWeather.condition
            humidityLabel.text = factWeather.humidity
            pressureLabel.text = factWeather.pressureMm
            windSpeedLabel.text = factWeather.windSpeed
            windDirLabel.text = factWeather.windDir
            sunriseLabel.text = factWeather.sunrise
            sunsetLabel.text = factWeather.sunset
            partName1Label.text = factWeather.parts[0].partName
            tempMinMax1Label.text = factWeather.parts[0].tempMinMax
            condition1Label.text = factWeather.parts[0].condition
            windSpeedDir1Label.text = factWeather.parts[0].windSpeedDir
            partName2Label.text = factWeather.parts[1].partName
            tempMinMax3Label.text = factWeather.parts[1].tempMinMax
            condition2Label.text = factWeather.parts[1].condition
            windSpeedDir2Label.text = factWeather.parts[1].windSpeedDir
            
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
            let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(factWeather.icon).svg")
            iconImageView.sd_setImage(with: url)
        }
    }
}
