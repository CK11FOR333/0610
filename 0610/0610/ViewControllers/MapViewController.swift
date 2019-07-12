//
//  MapViewController.swift
//  0610
//
//  Created by Chris on 2019/7/2.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    var cafes: [Cafe] = []

    var geoCoder = CLGeocoder()

    var locationManager = CLLocationManager()

    /// 地圖預設顯示的範圍大小 (數字越小越精確)
    let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationButton: UIButton!

    @IBAction func clickLocationButton(_ sender: UIButton) {
        // 設置委任對象
        locationManager.delegate = self
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        // 取得自身定位位置的精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest


        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            locationManager.requestWhenInUseAuthorization()

            // 開始定位自身位置
            locationManager.startUpdatingLocation()
        }
            // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus() == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController.init(title: "定位權限已關閉", message: "允許此App使用定位服務 請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            alertController.addAction(title: "確定", style: .default, isEnabled: true) { (action) in
                //
            }
            alertController.show()
        }
            // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // 開始定位自身位置
            locationManager.startUpdatingLocation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMapView()
        setupLocationButton()
        getJSON()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 停止定位自身位置
        locationManager.stopUpdatingLocation()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = UserDefaults.standard.bool(forKey: "kIsDarkTheme") ? .default : .black
        
        navigationController?.navigationBar.backgroundColor = Theme.current.navigationBar
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = Theme.current.tint
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.tint]
    }

    func setupMapView() {
//        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
    }

    func setupLocationButton() {
        locationImageView.image = UIImage(named: "google_location_con")?.withRenderingMode(.alwaysTemplate)
        locationImageView.tintColor = Theme.current.tint
        locationView.backgroundColor = Theme.current.accent
        locationView.layer.cornerRadius = 30
        locationView.layer.shadowColor = UIColor.black.cgColor
        locationView.layer.shadowOffset = CGSize(width: 0, height: 2)
        locationView.layer.shadowOpacity = 0.5
        locationView.layer.masksToBounds = false
    }

    func getJSON() {
        cafes = []

        requestManager.getYilanCafe { [weak self] (cafes) in
            guard let strongSelf = self else { return }
            strongSelf.cafes = cafes
            strongSelf.showCafes()
        }
    }

    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.tableViewBackground

        self.setupNavigationBar()

        self.tabBarController?.tabBar.barTintColor = Theme.current.tabBar
        self.tabBarController?.tabBar.tintColor = Theme.current.tint
        if #available(iOS 10.0, *) {
            self.tabBarController?.tabBar.unselectedItemTintColor = Theme.current.tabBarUnSelected
        } else {
            // Fallback on earlier versions
        }

        locationImageView.tintColor = Theme.current.tint
    }

    func showCafes() {
        var annotations: [MKPointAnnotation] = []
        for cafe in cafes {
            let location = CLLocation(latitude: Double(cafe.latitude)!, longitude: Double(cafe.longitude)!)
            let annotation = MKPointAnnotation()
            annotation.title = cafe.name
            annotation.subtitle = cafe.address
            annotation.coordinate = location.coordinate
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: true)
//        if annotations.count > 0 {
//            mapView.selectAnnotation(annotations.last!, animated: true)
//        }
    }

}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()

        // 印出目前所在位置座標
        let currentLocation = locations[0] as CLLocation
        log.info("Current Location latitude: \(currentLocation.coordinate.latitude), longitude: \(currentLocation.coordinate.longitude)")

        // 設置地圖顯示的範圍與中心點座標
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
    }
    
}
