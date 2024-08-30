//
//  DetailWeatherView.swift
//  Weather
//
//  Created by Adam Saxton on 8/30/24.
//

import SwiftUI

struct DetailWeatherView: View {
    let forecast: Forecast
    var body: some View {
        ZStack(alignment: .topLeading) {
            let color = UIColor(red: 0, green: 112, blue: 255, alpha: 1)
            Color.init(uiColor: color).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("\(forecast.cityStateOrCurrentLocation ?? ""), \(forecast.sys?.country ?? "US")").font(.system(size: 30))
                    HStack {
                        Text("\(forecast.main.currentTemp ?? 0.000)°F")
                        Spacer()
                        Text("Feels like: \(forecast.main.feelsLike ?? 0.000)°F")
                    }
                    Divider()
                    ForEach(forecast.weather, id: \.uniqueID) { weather in
                        HStack() {
                            Text(weather.mainDesc)
                            Spacer()
                            Image(data: forecast.image!)
                        }
                        Text(weather.secondaryDesc)
                        Divider()
                    }
                    Text("Minimum temperature in area: \(forecast.main.tempMin ?? 0.000)°F")
                    Text("Maximum temperature in area: \(forecast.main.tempMax ?? 0.000)°F")
                    Divider()
                    Text("Visibility: \(forecast.visibility ?? 0)")
                    Text("Humidity: \(forecast.main.humidity ?? 0)")
                    Text("Cloud cover: \(forecast.clouds?.clouds ?? 0)%")
                    Divider()
                    Text("Rain volume in the last 1 hr: \(forecast.rain?.oneHour ?? 0), and 3 hrs: \(forecast.rain?.threeHours ?? 0)").fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Snow volume in the last 1 hr: \(forecast.snow?.oneHour ?? 0), and 3 hrs: \(forecast.snow?.threeHours ?? 0)").fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Wind speed: \(forecast.wind?.speed ?? 0)")
                    Text("Gust: \(forecast.wind?.gust ?? 0)")
                    Text("Direction: \(forecast.wind?.deg ?? 0)°")
                    Divider()
                    Text("Pressure: \(forecast.main.pressure ?? 0)")
                    Text("Minimum pressure at sea level: \(forecast.main.atmPSea ?? 0)")
                    Text("Maximum pressure at ground level: \(forecast.main.atmPGround ?? 0)")
                    Divider()
                    Text("Timezone: \(forecast.timezone ?? 0)")
                    Text("Sunrise: \(forecast.sys?.sunrise ?? 0)").fixedSize(horizontal: false, vertical: true)
                    Text("Sunset: \(forecast.sys?.sunset ?? 0)").fixedSize(horizontal: false, vertical: true)
                    Divider()
                    Text("Weather forecast taken at: \(forecast.dt ?? 0)").fixedSize(horizontal: false, vertical: true)
                }.safeAreaPadding(.all)
            }
        }
    }
}

extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self = .init(uiImage: image)
    }
}

//#Preview {
//    DetailWeatherView(forecast: Forecast(coord: Coordinates(lon: 0.19, lat: -0.239847239), weather: [Weather(id: 500, mainDesc: "Cloudy", secondaryDesc: "Cloudy with slight drizzle", iconImageNumber: "10d"), Weather(id: 500, mainDesc: "Thunderstorm", secondaryDesc: "Thunderstorms in the area", iconImageNumber: "10d")], base: nil, main: OtherWeatherConditions(currentTemp: 80.9, feelsLike: 84.6, tempMin: 70, tempMax: 90, pressure: 505, humidity: 504, atmPSea: 507, atmPGround: 50), visibility: 49, wind: Wind(speed: 40.5, deg: 5, gust: 6), clouds: Clouds(clouds: 60), rain: Rain(oneHour: 90.4, threeHours: 7.8), snow: Snow(oneHour: 50.3, threeHours: 90.5), dt: 498574398759, sys: LocationInformation(type: nil, id: nil, message: nil, country: "US", sunrise: 979418759, sunset: 92845712398), timezone: 7200, id: 60, name: "Plano", cod: nil, image: nil, cityStateOrCurrentLocation: "Plano"))
//}
