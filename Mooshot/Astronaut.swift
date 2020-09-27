//
//  Astronaut.swift
//  Mooshot
//
//  Created by Paul Houghton on 22/09/2020.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
