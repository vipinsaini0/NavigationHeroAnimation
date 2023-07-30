//
//  Profile.swift
//  NavigationHeroAnimation
//
//  Created by Vipin Saini on 30-07-2023.
//

import Foundation

struct Profile: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

/// Sample Data
var profiles = [
    Profile(userName: "Justin", profilePicture: "pic1", lastMsg: "Hi john !!", lastActive: "10:26 PM"),
    Profile(userName: "Lucy", profilePicture: "pic2", lastMsg: "Hey buddy !!", lastActive: "11:16 AM"),
    Profile(userName: "Tonny", profilePicture: "pic3", lastMsg: "Nothing?", lastActive: "02:26 PM"),
    Profile(userName: "Jessy", profilePicture: "pic4", lastMsg: "Bingoo...!", lastActive: "01:26 PM"),
    Profile(userName: "David", profilePicture: "pic5", lastMsg: "Getting late", lastActive: "09:26 AM"),
]
