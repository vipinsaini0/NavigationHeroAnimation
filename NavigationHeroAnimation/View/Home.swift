//
//  Home.swift
//  NavigationHeroAnimation
//
//  Created by Vipin Saini on 30-07-2023.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    
    var body: some View {
        List {
            ForEach(profiles) { profile in
                Button(action: {
                    selectedProfile = profile
                    pushView.toggle()
                }, label: {
                    HStack(spacing: 15) {
                        Color.clear
                            .frame(width: 60,height: 60)
                        /// Source View Anchor
                            .anchorPreference(key: MAnchorKey.self, value: .bounds,
                                         transform: { anchor in
                            return [profile.id: anchor]
                        })
                        
                         
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .contentShape(.rect)
                })
            }
        }
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                ForEach(profiles) { profile in
                    /// Fetching Each Profile Image View using the Profile ID
                    /// Hiding the Currently TApped View
                    if let anchor = value[profile.id], selectedProfile?.id != profile.id {
                        let react = geometry[anchor]
                        ImageView(profile: profile, size: react.size)
                            .offset(x: react.minX, y: react.minY)
                            .allowsHitTesting(false)
                    }
                }
            })
        })
    }
}

struct DetailView: View {
    @Binding var selectionProfile: Profile?
    @Binding var pushView: Bool //  var profile: Profile
    @Binding var hideView: (Bool, Bool)
    
    var body: some View {
        if let selectionProfile {
            VStack {
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    VStack {
                        if hideView.0 {
                            ImageView(profile: selectionProfile, size: size)
                            /// Custom Close Button
                                .overlay(alignment: .top) {
                                    ZStack {
                                        Button(action: {
                                            /// Closing the View with animation
                                            hideView.0 = false
                                            hideView.1 = false
                                            pushView = false
                                            
                                            /// Average Navigation Pop takes 0.35s that's the reaon I set the animaiton duration as 0.35s, after the view is popped out, making selectedProfile to nil
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                self.selectionProfile = nil
                                            }
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .foregroundStyle(.white)
                                                .padding(10)
                                                .background(.black, in: .circle)
                                                .contentShape(.circle)
                                        })
                                        .padding(15)
                                        .padding(.top, 40)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        
                                        /// User name
                                        
                                        Text(selectionProfile.userName)
                                            .font(.title.bold())
                                            .foregroundStyle(.black)
                                            .padding(15)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                    }
                                    .opacity(hideView.1 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                                .onAppear(perform: {
                                    /// Removing the Animated View once the Animation is Finished
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        hideView.1 = true
                                    }
                                })
                        } else {
                            Color.clear
                        }
                    }
                    /// Destination View Anchor
                    .anchorPreference(key: MAnchorKey.self, value: .bounds,
                                      transform: { anchor in
                        return [selectionProfile.id: anchor]
                    })
                })
                .frame(height: 400)
                .ignoresSafeArea()
                
                Spacer(minLength: 0)
            }
            .toolbar(hideView.0 ? .hidden : .visible, for: .navigationBar)
            .onAppear(perform: {
                /// Removing the Animated View once the Animation is Finished
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    hideView.0 = true
                }
            })
        }
    }
}

struct ImageView: View {
    var profile: Profile
    var size: CGSize
    
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
        
        /// Linear Gradient at Bottom
            .overlay(content: {
                LinearGradient(colors: [
                    .clear,
                    .clear,
                    .clear,
                    .white.opacity(0.1),
                    .white.opacity(0.5),
                    .white.opacity(0.9),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .opacity(size.width > 60 ? 1 : 0)
            })
            .clipShape(.rect(cornerRadius: size.width > 60 ? 0 : 30))
    }
}

#Preview {
    ContentView()
}
