//
//  ContentView.swift
//  LanguageDetection
//
//  Created by Giuseppe Sica on 31/03/22.
//

import SwiftUI
import NaturalLanguage
import CoreML


struct ContentView: View {
    
    @State private var value = ""
    @State private var language = ""
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HStack{
            Text("Language Detection")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
                Image(systemName: "signature")
                    .font(.title)
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            TextField("Insert text here", text: $value)
                .font(.largeTitle)
                .padding()
            Spacer()
            
            Button ("Detect Language"){
                
                if let prediction = self.detectLanguage(text: self.value) {
                    self.language = prediction
                }
                
            }
            .frame(width: 150, height: 90, alignment: .center)
            .foregroundColor(.white)
            .background(.cyan)
            .cornerRadius(30)
            Spacer()
            Text("The predicted language is:")
                .font(.title)
            Text(self.language)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
    }
        .background(.blue)
    }
    
    private func detectLanguage(text: String) -> String?{
        
        let locale = Locale(identifier: "en")
        let recognizer = NLLanguageRecognizer()
        
        recognizer.processString(text)
        
        guard let language = recognizer.dominantLanguage else
        {
            return "Unable to predict language"
            
        }
        
        return locale.localizedString(forLanguageCode: language.rawValue)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
