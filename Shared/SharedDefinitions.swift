//
//  Definitions.swift
//  SemVer
//
//  Created by Andrew McKnight on 6/27/16.
//  Copyright © 2016 Two Ring Software. All rights reserved.
//

import Foundation

let errorDomain = "com.semver.dylib"

public enum SemVerFlags: UInt8 {
    case Key
    case File
    case Numeric
    case CurrentVersion

    public var long: String {
        switch self {
        case .Key:
            return "key"
        case .File:
            return "file"
        case .Numeric:
            return "numeric"
        case .CurrentVersion:
            return "current-version"
        }

    }

    public var short: String {
        switch self {
        case .Key:
            return "k"
        case .File:
            return "f"
        case .Numeric:
            return "n"
        case .CurrentVersion:
            return "c"
        }
    }
}
