//
//  RequestManager.swift
//  KGI
//
//  Created by mrfour on 3/2/16.
//  Copyright © 2016 mrfour. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

/// The Singleton that manages all requests
let requestManager = RequestManager.sharedInstance

enum ServerEnvironment {
    case test
    case production

    // Github API v3
    // 获取repo中某文件信息（不包括内容）。https://api.github.com/repos/用户名/gists/contents/文件路径。文件路径是文件的完整路径，区分大小写。只会返回文件基本信息。
    // 获取某文件的原始内容（Raw）。1. 通过上面的文件信息中提取download_url这条链接，就能获取它的原始内容了。2. 或者直接访问：https://raw.githubusercontent.com/用户名/仓库名/分支名/文件路径
    var domainString: String {
        switch self {
        case .test:
            var keys: NSDictionary?
            if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                keys = NSDictionary(contentsOfFile: path)
            }

            let testApiKeyDomain = keys?["ApiKeyDomainTest"] as? String ?? "https://raw.githubusercontent.com/KayHsiao/TestActivity"
            log.debug("testApiKeyDomain: \(testApiKeyDomain)")

            return testApiKeyDomain

        case .production:
            var keys: NSDictionary?
            if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                keys = NSDictionary(contentsOfFile: path)
            }

            let productionApiKeyDomain = keys?["ApiKeyDomainProduction"] as? String ?? "https://raw.githubusercontent.com/mbywczgxy/0610"
            log.debug("productionApiKeyDomain: \(productionApiKeyDomain)")

            return productionApiKeyDomain
        }
    }
}

struct AppAPI {
    static func stripURL(_ url: String) -> String {
        return requestManager.serverEnviroment.domainString + url
    }

    static let activitys   = stripURL("/master/Activities.json")
    static let course = stripURL("/master/Course.json")
    static let party = stripURL("/master/Party.json")
    static let popular = stripURL("/master/Popular.json")
    static let hot = stripURL("/master/Hot.json")
    static let marqueel = stripURL("/master/Marqueel.json")
}

class RequestManager {
    
    static let sharedInstance = RequestManager(.production)
    
    // MARK: Request Configuraion
    
    var serverEnviroment: ServerEnvironment
    
    private init(_ environment: ServerEnvironment) {
        self.serverEnviroment = environment
    }
    
    // MARK: Variables
    
    var currentRequest: Request?

    // MARK: Private Methods
    
    func baseRequest(_ method: Alamofire.HTTPMethod, url: String, parameters: [String: Any]? = nil, needToken: Bool = true, callback: @escaping (_ result :JSON) -> ()) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        SVProgressHUD.show()

        currentRequest = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response -> Void in

                switch response.result {
                case .success:

                    SVProgressHUD.dismiss(withDelay: 0.5)

                    if let value = response.result.value {
//                        log.info(value)
                        let json = JSON(value)

                        callback(json)
                    }
                case .failure(let error):

                    SVProgressHUD.dismiss()


//                    let currentVC = appDelegate.findCurrentViewController()
//                    let alertVC = AlertViewController.instantiateFromStoryboard()
//                    alertVC.titleSting = ""
//                    alertVC.messageString = error.localizedDescription
//                    alertVC.confirmString = "確定"
//                    currentVC.present(alertVC, animated: true, completion: nil)
                    log.debug(error.localizedDescription)
                    appDelegate.presentAlertView("網路錯誤", message: nil)
                    return
                }
        }
    }

}

// MARK: - Public Methods

extension RequestManager {
    
    // MARK: Fuction
    
    func cancelRequest() {
        guard let currentRequest = currentRequest else { return }

        log.debug("Canceled current request!!")
        currentRequest.cancel()
    }
    
    // MARK: API

    /// UITabBar 顯示畫面數
    func getActivitys(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.activitys, parameters: nil, needToken: false, callback: success)
    }

    /// 所有功能頁
    func getＣourse(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.course, parameters: nil, needToken: false, callback: success)
    }

    /// 活动优惠
    func getParty(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.party, parameters: nil, needToken: false, callback: success)
    }

    /// 彩金申请
    func getPopular(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.popular, parameters: nil, needToken: false, callback: success)
    }

    ///
    func getHot(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.hot, parameters: nil, needToken: false, callback: success)
    }

    /// 
    func getMarqueel(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.marqueel, parameters: nil, needToken: false, callback: success)
    }

    /// 台北咖啡廳
    func getTaipeiCafe (success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: "https://cafenomad.tw/api/v1.2/cafes/taipei", parameters: nil, needToken: false, callback: success)
    }

    /// 宜蘭咖啡廳
    func getYilanCafe (success: @escaping (_ cafes: [Cafe]) -> Void) {
        baseRequest(.get, url: "https://cafenomad.tw/api/v1.2/cafes/yilan") { (json) in
            let cafeArray = json.arrayValue
            log.info("cafeArray count is \(cafeArray.count)")

            var cafes: [Cafe] = []

            for key in cafeArray {
                let cafe = Cafe(id: key["id"].stringValue,
                                mrt: key["mrt"].stringValue,
                                url: key["url"].stringValue,
                                city: key["city"].stringValue,
                                name: key["name"].stringValue,
                                socket: key["socket"].stringValue,
                                address: key["address"].stringValue,
                                longitude: key["longitude"].stringValue,
                                latitude: key["latitude"].stringValue,
                                limited_time: key["limited_time"].stringValue,
                                standing_desk: key["standing_desk"].stringValue,
                                wifi: key["wifi"].intValue,
                                seat: key["seat"].intValue,
                                quiet: key["quiet"].intValue,
                                tasty: key["tasty"].intValue,
                                cheap: key["cheap"].intValue,
                                music: key["music"].intValue)
                cafes.append(cafe)
            }

            success(cafes)
        }
    }

    /// 全台咖啡廳
    func getCafe(with name: String, success: @escaping (_ cafes: [Cafe]) -> Void) {
        baseRequest(.get, url: "https://cafenomad.tw/api/v1.2/cafes/\(name)") { (json) in
            let cafeArray = json.arrayValue
            log.info("cafeArray count is \(cafeArray.count)")

            var cafes: [Cafe] = []

            for key in cafeArray {
                let cafe = Cafe(id: key["id"].stringValue,
                                mrt: key["mrt"].stringValue,
                                url: key["url"].stringValue,
                                city: key["city"].stringValue,
                                name: key["name"].stringValue,
                                socket: key["socket"].stringValue,
                                address: key["address"].stringValue,
                                longitude: key["longitude"].stringValue,
                                latitude: key["latitude"].stringValue,
                                limited_time: key["limited_time"].stringValue,
                                standing_desk: key["standing_desk"].stringValue,
                                wifi: key["wifi"].intValue,
                                seat: key["seat"].intValue,
                                quiet: key["quiet"].intValue,
                                tasty: key["tasty"].intValue,
                                cheap: key["cheap"].intValue,
                                music: key["music"].intValue)
                cafes.append(cafe)
            }

            success(cafes)
        }
    }

}
