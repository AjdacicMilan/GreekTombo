//
//  ApiManager.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import Alamofire

class ApiManager {
    
    enum Constants {
        static var baseUrl: String = "https://api.opap.gr/draws/v3.0"
        static var baseHeaders: HTTPHeaders = HTTPHeaders.default
    }
    
    static func fetchNextDraws(count: Int = 20, completion: @escaping ([Draw]) -> Void) {
        let urlPath = "\(Constants.baseUrl)/\(GameType.greekTombo.rawValue)/upcoming/\(count)"
        guard let url = try? urlPath.asURL() else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.headers = Constants.baseHeaders
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        Session.greekTomboSession.request(request, interceptor: CustomInterceptor()).responseDecodable(of: [Draw].self, completionHandler: { response in
            switch response.result {
            case .success(let draws):
                let sortedDraws = draws.sorted(by: { $0.drawTime < $1.drawTime })
                DataManager.shared.draws = sortedDraws
                completion(sortedDraws)
                break
            case .failure(_):
                completion([])
                break
            }
        })
    }
    
    static func fetchDrawDetails(drawId: Int, completion: @escaping (Draw?) -> Void) {
        let urlPath = "\(Constants.baseUrl)/\(GameType.greekTombo.rawValue)/\(drawId)"
        guard let url = try? urlPath.asURL() else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.headers = Constants.baseHeaders
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        Session.greekTomboSession.request(request, interceptor: CustomInterceptor()).responseDecodable(of: Draw.self, completionHandler: { response in
            switch response.result {
            case .success(let draw):
                completion(draw)
                break
            case .failure(_):
                completion(nil)
                break
            }
        })
    }
    
    static func fetchScores(daysBefore: Int = 0, saveDataInSession: Bool = false, completion: (([Draw]) -> Void)? = nil) {
        let date = Date().addingTimeInterval(-Double(daysBefore) * 24 * 60 * 60)
        let dateDisplay = DateFormatter.customDateFormater.string(from: date)
        let urlPath = "\(Constants.baseUrl)/\(GameType.greekTombo.rawValue)/draw-date/\(dateDisplay)/\(dateDisplay)"
        guard let url = try? urlPath.asURL() else {
            completion?([])
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.headers = Constants.baseHeaders
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        Session.greekTomboSession.request(request, interceptor: CustomInterceptor()).responseDecodable(of: Score.self, completionHandler: { response in
            switch response.result {
            case .success(let score):
                let sortedDraws = score.content.sorted(by: { $0.drawTime > $1.drawTime })
                if saveDataInSession {
                    DataManager.shared.draws = sortedDraws
                }
                completion?(sortedDraws)
                break
            case .failure(_):
                completion?([])
                break
            }
        })
    }
}
