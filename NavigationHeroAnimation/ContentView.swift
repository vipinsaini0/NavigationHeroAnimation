//
//  ContentView.swift
//  NavigationHeroAnimation
//
//  Created by Vipin Saini on 30-07-2023.
//

import SwiftUI

struct ContentView: View {
/// View Properties
    @State private var selectedProfile: Profile?
    @State private var pushView: Bool = false
    @State private var hideView: (Bool, Bool) = (false, false)
    
    var body: some View {
        NavigationStack {
            Home(selectedProfile: $selectedProfile, pushView: $pushView)
                .navigationTitle("Profile")
                .navigationDestination(isPresented: $pushView) {
                    DetailView(selectionProfile: $selectedProfile, pushView: $pushView, hideView: $hideView)
                }
        }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                if let selectedProfile, let anchor = value[selectedProfile.id], !hideView.0 {
                    let react = geometry[anchor]
                    ImageView(profile: selectedProfile, size: react.size)
                        .offset(x: react.minX, y: react.minY)
                    /// Simply Animating the react will add the geometry Effact we needed
                        .animation(.snappy(duration: 0.35, extraBounce: 0), value: react)
                 }
            })
        })
    }
}

#Preview {
    ContentView()
}
