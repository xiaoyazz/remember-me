//
//  FacesILoveView.swift
//  remember-me
//
//  Created by Xiaoya Zou on 2025-03-29.
//

import SwiftUI

struct FamilyMember: Identifiable {
    let id = UUID()
    let name: String
    let relation: String
    let imageName: String
}

struct FacesILoveView: View {
    let familyMembers: [FamilyMember] = [
        FamilyMember(name: "Anna", relation: "My daughter", imageName: "Daughter2"),
        FamilyMember(name: "Kai", relation: "My cousin", imageName: "cousin"),
        FamilyMember(name: "Elsa", relation: "My daughter", imageName: "Daughter"),
        FamilyMember(name: "Catherine", relation: "My sister", imageName: "sister"),
        FamilyMember(name: "Mei", relation: "My grand daughter", imageName: "Grand-Daughter"),
        FamilyMember(name: "Ben", relation: "My brother", imageName: "brother")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    ForEach(familyMembers) { member in
                        VStack(spacing: 20) {
                            Spacer()
                            
                            Image(member.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 250)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                            
                            Text(member.name)
                                .font(.title)
                                .bold()
                            
                            Text(member.relation)
                                .font(.title3)
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                
                // Left Arrow
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .font(.system(size: 24))
                        .padding()
                        .opacity(0.7)
                    
                    Spacer()
                    
                    // Right Arrow
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.system(size: 24))
                        .padding()
                        .opacity(0.7)
                }
            }
            .navigationTitle("Faces I Love")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FacesILoveView()
}
