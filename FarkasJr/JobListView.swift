//
//  JobListView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 06/02/2023.
//

import SwiftUI

struct JobListView: View {
    
    let jobListDescriptions = ["Plan App Structure", "Design Menu View", "Design Game View", "Plan Instrument and Note Storage", "New or reused note display code?", "New listening code: Audiokit?" , "Decide where to start", "Should I reuse anything?", "Move Job List into struct and display seperately"]
    
    @State private var jobList: [Job] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Job List:")
                .font(.title)
                .padding()
            List(jobList) { job in
                Text(job.description)
            }
        }
        .onAppear {
            jobList = jobListDescriptions.map {
                Job(description: $0)
            }
        }
    }
}



struct JobListView_Previews: PreviewProvider {
    static var previews: some View {
        JobListView()
    }
}
