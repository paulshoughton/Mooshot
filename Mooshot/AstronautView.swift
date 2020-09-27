//
//  AstronautView.swift
//  Mooshot
//
//  Created by Paul Houghton on 23/09/2020.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let astronautMissions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                        .font(.headline)
                    
                    List(astronautMissions, id: \.id) { mission in
                        MissionRow(mission: mission, showCrew: false)
                    }
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        var matches = [Mission]()
        
        for mission in missions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matches.append(mission)
            }
        }
                
        self.astronautMissions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
