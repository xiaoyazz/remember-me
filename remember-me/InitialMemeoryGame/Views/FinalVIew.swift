//
//  FinalView.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct FinalView: View {
    @EnvironmentObject var metricsLogger: MetricsLogger
    
    var body: some View {
        VStack {
            Text("Thank you for playing Memory Quest!")
                .font(.largeTitle)
                .padding()
            
            Text("Your performance metrics have been recorded.")
                .padding()
            
            List(metricsLogger.logs, id: \.self) { log in
                Text(log)
            }
        }
        .navigationTitle("Summary")
    }
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FinalView().environmentObject(MetricsLogger())
        }
    }
}
