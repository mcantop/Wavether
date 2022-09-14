//
//  ContentView.swift
//  Wavether
//
//  Created by Maciej on 13/09/2022.
//

import SwiftUI

struct ContentView: View {
    let weatherService = WeatherService()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let weather = weather {
                WeatherView(weather: weather)
            } else {
                ZStack {
                    Waves()
                    ProgressView()
                        .task {
                            do {
                                weather = try await weatherService.getWeather(longtitude: 18.649059, latitude: 54.258389)
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                }
            }
        }
        .font(.system(.body, design: .rounded))
        .foregroundColor(.white)
        .background(Color(red: 0.0, green: 0.10196078431372549, blue: 0.2)) // night
        //        .background(Color(red: 0.6705882352941176, green: 0.8470588235294118, blue: 0.9176470588235294))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
