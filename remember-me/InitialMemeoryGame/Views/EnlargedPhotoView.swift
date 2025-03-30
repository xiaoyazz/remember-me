//
//  EnlargedPhotoView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct EnlargedPhotoView: View {
    let imageName: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea() // cover full screen
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct EnlargedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        EnlargedPhotoView(imageName: "ZooAnimals")
    }
}

