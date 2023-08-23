//
//  ProfileView.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 23/08/2023.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    let store: Store<ProfileDomain.State, ProfileDomain.Action>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ZStack {
                    Form {
                        Section {
                            Text(viewStore.profile.firstName.capitalized)
                            +
                            Text(" \(viewStore.profile.lastName.capitalized)")
                        } header: {
                            Text("Full name")
                        }
                        
                        Section {
                            Text(viewStore.profile.email)
                        } header: {
                            Text("Email")
                        }
                    }
                    
                    if viewStore.isLoading {
                        ProgressView()
                    }
                }
                .task {
                    viewStore.send(.fetchUserProfile)
                }
                .navigationTitle("Profile")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            store: Store(initialState: ProfileDomain.State()) {
                ProfileDomain(fetchUserProfile: { .sample })
            }
        )
    }
}
