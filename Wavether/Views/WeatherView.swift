//
//  WeatherView.swift
//  Wavether
//
//  Created by Maciej on 14/09/2022.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack {
            Waves()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Text("Pruszcz Gdański")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    
                    HStack {
                        Text("\(weather.current.feelsLike.roundDouble())°")
                            .font(.system(size: 100))
                        VStack(spacing: 40) {
                            Text("H: \(weather.daily[0].temp.max.roundDouble())°")
                            Text("L: \(weather.daily[0].temp.min.roundDouble())°")
                        }
                    }
                    
                    VStack(spacing: 0) {
                        Text(descToIcon(description: weather.current.weather[0].main))
                            .font(.system(size: 100))
                            .fontWeight(.thin)
                            
                        Text(weather.current.weather[0].description.capitalized)
                    }
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach((0...12), id: \.self) { hour in
                                VStack(spacing: 7) {
                                    Text(hour == 0 ? "Now" : "\(Date.now.addingTimeInterval(Double(hour) * 3600).formatted(.dateTime.hour()))")
                                    Text(descToIcon(description: weather.hourly[hour].weather[0].main))
                                    Text("\(weather.hourly[hour].feelsLike.roundDouble())°")
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical)
                            }
                        }
                    }
                    .background(.ultraThinMaterial)
                    .cornerRadius(30)
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 30) {
                            ForEach((0...7), id: \.self) { day in
                                HStack(alignment: .center, spacing: 20) {
                                    Text(day == 0 ? "Today" :
                                        "\(Date.now.addingTimeInterval(Double(day) * 86400).formatted(.dateTime.weekday()))")
                                    .frame(width: 50, alignment: .leading)
                                    Spacer()
                                    Text(descToIcon(description: weather.daily[day].weather[0].main))
                                    Spacer()
                                    Text("L: \(weather.daily[day].temp.min.roundDouble())")
                                    Text("H: \(weather.daily[day].temp.max.roundDouble())")

                                }

                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
                    .cornerRadius(30)
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .animation(.default, value: true)
        .font(.system(.body, design: .rounded))
        .foregroundColor(.white)
        .background(Color(red: 0.0, green: 0.10196078431372549, blue: 0.2)) // night
        //        .background(Color(red: 0.6705882352941176, green: 0.8470588235294118, blue: 0.9176470588235294))
    }
    
    func descToIcon(description: String) -> Image {
        switch description.lowercased() {
        case "clouds":
            return Image(systemName: "cloud")
        default:
            return Image(systemName: "sun.max")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weather: previewWeather)
    }
}
