//
//  Instrument.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/24/20.
//

import Foundation

struct Instrument {
    
    let type : InstrumentType
    let notes: [Note]
    
    
    
    
}

enum InstrumentType: String {
    case grandPiano = "Grand Piano"
    case acousticGuitar = "Acoustic Guitar"
}
