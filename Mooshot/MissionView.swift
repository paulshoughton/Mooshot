//
//  MissionView.swift
//  Mooshot
//
//  Created by Paul Houghton on 23/09/2020.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionCrew {
    let mission: Mission
    let missionAstronauts: [CrewMember]
    
    init(mission: Mission) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            }
            else {
                fatalError("Missing \(member)")
            }
        }
        
        self.missionAstronauts = matches
    }
    
}

struct MissionRow: View {
    var mission: Mission
    var missionAstronauts: [CrewMember]
    let showCrew: Bool
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                if (self.showCrew) {
                    ForEach(missionAstronauts, id: \.role) {  crewMember in
                            Text(crewMember.astronaut.name)
                                .foregroundColor(.secondary)
                    }
                }
                else {
                    Text(mission.formattedLaunchDate)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    init(mission: Mission, showCrew: Bool) {
        self.mission = mission
        self.showCrew = showCrew

        let missionCrew = MissionCrew(mission: mission)

        self.missionAstronauts = missionCrew.missionAstronauts
    }
}

struct MissionView: View {
    
    let mission: Mission
    let missionAstronauts: [CrewMember]
//    let crew: Crew
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.formattedLaunchDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.missionAstronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .stroke(Color.primary, lineWidth: 1)
                                                )
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission) {
        self.mission = mission

        let missionCrew = MissionCrew(mission: mission)

        self.missionAstronauts = missionCrew.missionAstronauts
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0])
        MissionRow(mission: missions[0], showCrew: false)
            .previewLayout(.fixed(width: 300, height: 70))
        MissionRow(mission: missions[0], showCrew: true)
            .previewLayout(.fixed(width: 300, height: 90))
    }
}
