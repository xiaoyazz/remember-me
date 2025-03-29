//
//  GameTitle.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct CustomTitleView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
}

#Preview {
    CustomTitleView(title: "This is a test title")
}
