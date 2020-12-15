//
//  MapViewController.swift
//  Weather
//
//  Created by Alex on 24.11.2020.
//

import UIKit
import MapKit

protocol MapViewProtocol: class {
    func showMap(for cityName: String, coordinate: CLLocationCoordinate2D?)
}

class MapViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Propertis
    
    private let presenter: MapPresenterProtocol
    private var pointAnnotation = MKPointAnnotation()
    private var isShowAnnotation = false
    private var rightBarButtonItem: UIBarButtonItem!
    private var pressCoordinate: CLLocationCoordinate2D! {
        didSet {
            rightBarButtonItem.isEnabled = true
        }
    }
    
    // MARK: - Init
    
    init(presenter: MapPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.start()
    }
    
    //MARK: - Metods
    
    private func setupUI() {
        rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPress))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        rightBarButtonItem.isEnabled = false
    }
    
    @objc
    private func saveButtonPress() {
        presenter.saveCoordinate(pressCoordinate)
    }
    
    //MARK: - IBActions
    
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        let pressPoint = sender.location(in: mapView)
        pressCoordinate = mapView.convert(pressPoint, toCoordinateFrom: mapView)
        pointAnnotation.coordinate = pressCoordinate
        if !isShowAnnotation { mapView.addAnnotation(pointAnnotation) }
    }
    
}

//MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
    func showMap(for cityName: String, coordinate: CLLocationCoordinate2D?) {
        pointAnnotation.title = cityName
        guard let coordinate = coordinate else { return }
        let regionDistance: CLLocationDistance = 50000
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(coordinateRegion, animated: true)
        pointAnnotation.coordinate = coordinate
        mapView.addAnnotation(pointAnnotation)
        isShowAnnotation = true
    }
}
