//
//  ViewController.swift
//  templates
//
//  Created by Imran Baloch on 12/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getCity(versionCode: "5")
    }
    
    func login() {
        let endPoint = APIEndPoint.OnBoarding.login(userName: "", password: "").endPoint
        APIManager.sharedInstance.execute(endPoint) { (response: Result<LoginResponse>) in
            switch response {
            case .success(let loginResponse):
                Log.d(loginResponse)
            case .failure(let error):
                Log.e(error)
            }
        }
    }
    
    func getCity(versionCode: String) {
        let endPoint = APIEndPoint.OnBoarding.getCity(versionCode: versionCode).endPoint
        APIManager.sharedInstance.execute(endPoint) { (response: Result<CityListResponse>) in
            switch response {
            case .success(let loginResponse):
                Log.d(loginResponse)
            case .failure(let error):
                Log.e(error)
            }
        }
    }
}

struct LoginResponse: Codable {
    var userId: String?
    var userName: String?
    
}

// MARK: - primaryGenreNameWelcome
struct CityListResponse: Codable {
    var body: CityListBody?
    var responseCode: Int?
    var msg: String?
}

// MARK: - primaryGenreNameBody
struct CityListBody: Codable {
    var cityDetail: [CityDetail]?
}

// MARK: - primaryGenreNameCityDetail
struct CityDetail: Codable {
    var cityID: Int?
    var cityName, createdDate: String?
    var isActive, isDeleted: Bool?

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityName, createdDate, isActive, isDeleted
    }
}

