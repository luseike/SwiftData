//
//  SampleData.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/21.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    // use the same model container in all your previews
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var friend: Friend {
        Friend.sampleData.first!
    }
    var movie: Movie {
        Movie.sampleData.first!
    }
    private init() {
        
        // schema include your model types
        let schema = Schema([
            Friend.self,
            Movie.self
        ])
        
        // 创建一个模型配置，传递模型并指定它应该将数据保存在内存中而不是持久保存
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for friend in Friend.sampleData {
            context.insert(friend)
        }
        
        for movie in Movie.sampleData {
            context.insert(movie)
        }
        
        // 当你在关系的一端设置属性时，swiftdata会自动为你更新另一端的相应属性，你可以选择设置这两个属性中的哪一个
        Friend.sampleData[0].favoriteMovie = Movie.sampleData[1]
        Friend.sampleData[2].favoriteMovie = Movie.sampleData[0]
        Friend.sampleData[3].favoriteMovie = Movie.sampleData[4]
        Friend.sampleData[4].favoriteMovie = Movie.sampleData[0]
    }
}
