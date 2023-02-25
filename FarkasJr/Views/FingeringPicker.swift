//
//  FingeringPicker.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 24/02/2023.
//

import SwiftUI

struct FingeringPicker: View {
    @Binding var noteByNum: NoteByNum
    let instrument: Instrument
    let fingerings: [Fingering]
    let options: [Fingering]
    
    init(noteByNum: Binding<NoteByNum>, instrument: Instrument) {
        self._noteByNum = noteByNum
        self.instrument = instrument
        let num = noteByNum.wrappedValue.num
        self.options = instrument.fingeringOptionsByNum(num)
        self.fingerings = Array(Set(instrument.availableFingerings + options)).sorted { $0.rawValue < $1.rawValue }
    }
    
    var body: some View {
        Picker("", selection: $noteByNum.fingering) {
                ForEach(fingerings, id: \.self) {
                    Text("\($0.rawValue) \(options.contains($0) ? "✅" : "")")
                        .foregroundColor(instrument.fingeringOptionsByNum(noteByNum.num).contains($0) ? .green : .red)
            }
        }
        .pickerStyle(.menu)
        .frame(height: 100)
        .onChange(of: noteByNum.fingering) { newValue in
            print("Value Changed")
        }
    }
}

struct FingeringPicker_Previews: PreviewProvider {
    static var previews: some View {
        FingeringPicker(noteByNum: .constant(Instrument.hornF.notes.first!), instrument: .hornF)
    }
}
