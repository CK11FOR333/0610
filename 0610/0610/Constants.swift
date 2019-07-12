//
//  Constants.swift
//  0610
//
//  Created by Chris on 2019/7/4.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

let appBundleIdentifier = Bundle.main.bundleIdentifier ?? ""
let appVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
let appBuildString = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
