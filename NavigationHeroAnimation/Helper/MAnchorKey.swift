//
//  MAnchorKey.swift
//  NavigationHeroAnimation
//
//  Created by Vipin Saini on 30-07-2023.
//

import SwiftUI

/// For Reading the source and Destination View Bounds for our Custom MAtched Geometry Effect
struct MAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
