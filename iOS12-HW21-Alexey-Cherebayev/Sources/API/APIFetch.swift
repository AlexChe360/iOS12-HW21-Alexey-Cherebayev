//
//  APIFetch.swift
//  iOS12-HW21-Alexey-Cherebayev
//
//  Created by Alex on 10.04.2024.
//

import Foundation
import Alamofire

class APIFetch {
    static let sharedInstance = APIFetch()
    func fetchAPIData(handler: @escaping (_ apiData: Cards) -> Void) {
        let url = "https://api.magicthegathering.io/v1/cards?name=Opt|BlackLotus"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { res in
                switch res.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(Cards.self, from: data!)
                        handler(jsonData)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func searchDataByName(name: String, handler: @escaping (_ apiData: Cards) -> Void) {
        let url = "https://api.magicthegathering.io/v1/cards?name=\(name)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { res in
                switch res.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(Cards.self, from: data!)
                        handler(jsonData)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
