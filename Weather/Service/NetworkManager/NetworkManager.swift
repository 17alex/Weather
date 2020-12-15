//
//  NetworkManager.swift
//  Weather
//


import Foundation
import CoreLocation

class NetworkManager {
    private func taskResume(urlRequest: URLRequest, complete: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error { complete(.failure(error)) }
            else if let data = data { complete(.success(data)) }
            else { complete(.failure("Not recived data")) }
        }.resume()
    }
    
    private func onMain(_ blok: @escaping () -> Void) {
        DispatchQueue.main.async { blok() }
    }
}

//MARK: - NetworkManagerProtocol

extension NetworkManager: NetworkManagerProtocol {
    func getWeather(location: CLLocationCoordinate2D, complete: @escaping (Result<ServerWeather, Error>) -> Void) {
        let urlString = "https://api.weather.yandex.ru/v2/informers?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru_RU"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url, timeoutInterval: 90)
        request.httpMethod = "GET"
        request.addValue("80c94244-6728-44f8-ac52-96d11e008dd9", forHTTPHeaderField: "X-Yandex-API-Key")
        
        taskResume(urlRequest: request) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.onMain { complete(.failure(error)) }
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(ServerWeather.self, from: data)
                    self?.onMain { complete(.success(weather)) }
                } catch let error {
                    self?.onMain { complete(.failure(error)) }
                }
            }
        }
    }
}
