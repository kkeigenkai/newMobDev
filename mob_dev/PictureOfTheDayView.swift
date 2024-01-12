//
//  PictureOfTheDayView.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 10.01.2024.
//

import SwiftUI

struct PictureOfTheDayView: View {
    @EnvironmentObject var network: Network
    @State var date = Date.now
    
    let dateRange: ClosedRange<Date> = {
        let to = Date.now
        let from = Date(timeIntervalSince1970: 0)
        return from...to
    }()
    
    var body: some View {
        VStack {
            Text("Picture Of The Day")
                .font(.title).bold()
            Text("For \(date.formatted(.dateTime.day().month().year()))")
                .font(.title3).bold()
            VStack(alignment: .center) {
                YoutubeVideoView(url: network.pictureOfTheDay.url)
                Text("\(network.pictureOfTheDay.title)").font(.title2).bold()
                    .multilineTextAlignment(.center)
                ScrollView{
                    Text(network.pictureOfTheDay.explanation)
                }.padding()
                
                DatePicker(
                    "Day: ",
                    selection: $date,
                    in: dateRange,
                    displayedComponents: [.date]
                ).padding().onChange(of: date) {
                    network.getPicktureOfTheDay(day: date)
                }.datePickerStyle(CompactDatePickerStyle()).fixedSize()
            }
            .onAppear {
                network.getPicktureOfTheDay(day: date)
            }
        }
    }
}
