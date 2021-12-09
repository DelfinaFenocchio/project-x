//
//  BEComunication.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 25/11/2021.
//

import SwiftUI

struct WelcomeElement: Codable, Hashable {
    let type: TypeEnum
    let name: String
    let files: [WelcomeElement]?
}

enum TypeEnum: String, Codable {
    case directory = "directory"
    case file = "file"
}

typealias Welcome = [WelcomeElement]

struct BEComunication: View {
    @State private var results = Welcome()

        var body: some View {
            if #available(iOS 15.0, *) {
                Text("Resultado")

                List(results, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("Element: \(item.name)")
//                        Text(item.name)
//                            .font(.headline)
//                        Text(item.type)
                    }
                }
                .task {
                    print("Entro al task")
                    await loadData()
                }
                
            } else {
                Text("Fallback on earlier versions").onAppear {
                    print("Else available 15.0")
                }
            }
        }
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
    @available(iOS 15.0.0, *)
    func loadData() async {
        guard let url = URL(string: "https://images.unsplash.com/photo-1555679427-1f6dfcce943b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODAxNzN8MHwxfGFsbHx8fHx8fHx8fDE2Mzg5MDk1MjM&ixlib=rb-1.2.1&q=80&w=400") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            print("Antes: \(data)")
            

//            if let welcome = try? JSONDecoder().decode(Welcome.self, from: data) {
//                results = welcome
//                print("Después: \(welcome)")
//                print("Después con result: \(welcome)")
//            }
            
    
            print("Después y afuera del if")
        } catch {
            print("Invalid data")
        }
    }
}
