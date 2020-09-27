//
//  ContentView.swift
//  Mooshot
//
//  Created by Paul Houghton on 21/09/2020.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText: \(text)")
        self.text = text
    }
    
}

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
//    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
//    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var showCrew = false
    
    var body: some View {
        
//        VStack {
//            Image("Singapore")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 300, height: 300)
//            GeometryReader { geo in
//                Image("Singapore")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geo.size.width)
//            }
//        }

//        ScrollView(.vertical) {
//            VStack(spacing: 10) {
//                ForEach(0..<100) {
//                    CustomText("Item \($0)")
//                        .font(.title)
//                }
//
//            }
//            .frame(maxWidth: .infinity)
//        }
//    }
        
//        List {
//            ForEach(0..<100) {
//                CustomText("Item \($0)")
//                    .font(.title)
//            }
//        }
        
//        NavigationView {
//            VStack {
//                NavigationLink(destination: Text("Detail View")) {
//                    Text("Hello World")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
//
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detail \(row)")) {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
        
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name": "Taylor Swift",
//                "address": {
//                    "street": "555, Taylor Swift Avenue",
//                    "city": "Nashville"
//                }
//            }
//            """
//
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
        
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination:
                        MissionView(mission: mission)
                ) {
                    MissionRow(mission: mission, showCrew: showCrew)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(self.showCrew ? "Show Dates": "Show Crew") {
                self.showCrew.toggle()
            } )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
