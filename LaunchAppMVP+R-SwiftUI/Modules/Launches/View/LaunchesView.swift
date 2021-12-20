//
//  LaunchesView.swift
//  LaunchAppMVVM-SwiftUI
//
//  Created by Anton Vlezko on 18.12.2021.
//

import SwiftUI
import UIKit
import Kingfisher

struct LaunchesView: View {
    
    // MARK: - Properties
    
    @ObservedObject var model: LaunchesViewModel = LaunchesViewModel()
    
    // MARK: - Construction
    
    var body: some View {
        List {
            ForEach(model.launches, id: \.id) { launch in
                configureLaunchCell(with: launch)
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - Helper Functions

extension LaunchesView {
    private func configureLaunchCell(with launch: LaunchesCellViewModel) -> some View {
        HStack(alignment: .top, spacing: Constants.standartPadding) {
            if let url = URL(string: launch.imageURL) {
                configurePatchImage(with: url)
                    .resizable()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            } else {
                Image(uiImage: UIImage(named: "logo")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            }
            
            VStack(alignment: .leading, spacing: Constants.standartPadding) {
                Text(launch.name)
                    .font(Font.titleFont)
                Text(launch.launchYear)
                    .font(Font.subtitleFont)
                Text(launch.details)
                    .font(Font.bodyFont)
            }
        }
    }
    
    private func configurePatchImage(with url: URL) -> KFImage {
        KFImage(url)
            .placeholder {
                // Placeholder while downloading.
                Image(systemName: "arrow.2.circlepath.circle")
                    .font(.largeTitle)
                    .opacity(0.3)
            }
            .retry(maxCount: 3, interval: .seconds(5))
            .onSuccess { r in
                // r: RetrieveImageResult
                print("success: \(r)")
            }
            .onFailure { e in
                // e: KingfisherError
                print("failure: \(e)")
            }
            .resizable()
    }
}

// MARK: - LaunchesView_Previews

struct LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        let model = LaunchesViewModel()
        let launch = LaunchesCellViewModel(
            name: "FalconSet",
            details: "Falcon 9 is a reusable, two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of people and payloads into Earth orbit and beyond. Falcon 9 is the world’s first orbital class reusable rocket.",
            launchYear: "2006",
            imageURL: "")
        
        model.launches.append(launch)
        
        return LaunchesView(
            model: model
        )
    }
}
