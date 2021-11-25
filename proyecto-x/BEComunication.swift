//
//  BEComunication.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 25/11/2021.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var name: String
}

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let array : [String] = ["Hola", "Chao"]

struct BEComunication: View {
    @State private var results = [Result]()

        var body: some View {
            if #available(iOS 15.0, *) {
                Text("Resultado")

                List(array, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("Elemento: \(item)")
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
    
    @available(iOS 15.0.0, *)
    func loadData() async {
        guard let url = URL(string: "https://run.mocky.io/v3/bc690c54-210f-4587-a9d0-fdedf1d5e048") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            print("Antes: \(data)")
            

//            let decodedResponse = try JSONDecoder().decode([Result].self, from: data)
//            results = decodedResponse
//            print("Después: \(decodedResponse)")
//            print("Después con result: \(decodedResponse)")
            
            
            let json = """
            {
                "name": "Durian",
                "points": 600,
                "description": "A fruit with a distinctive scent."
            }
            """.data(using: .utf8)!
            
            print("json: \(json)")

            let decoder = JSONDecoder()
            let product = try decoder.decode(GroceryProduct.self, from: json)
            print("product: \(product)")
            
            
            print("Después y afuera del if")
            
        } catch {
            print("Invalid data")
        }
    }
}
