//
//  DataManager.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import Foundation
import CoreData

enum ModifyType {
    case delete
    case amend
}

struct ModifyInfomation {
    var type: ModifyType
    var index: Int
}

class DataManager {

    @Published
    var images = [Images]()
    
    private let persistentContainer: NSPersistentContainer
    var modifyInfomation: ModifyInfomation? {
        didSet {
            guard let modifyInfomation = self.modifyInfomation else { return }
            if modifyInfomation.type == .delete {
                self.deleteData(modifyInfomation.index)
            }
        }
    }

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: nil, queue: nil) { (notification) in
            persistentContainer.viewContext.mergeChanges(fromContextDidSave: notification)
            self.loadData()
        }
    }
    
    func loadData() {
        //코어 데이터를 로딩해서  self.items = 로드한 데이터
        self.persistentContainer.viewContext.perform {
            let fetchRequest: NSFetchRequest = Images.fetchRequest()
            let sortDescriptors = NSSortDescriptor(keyPath: \Images.date, ascending: false)
            fetchRequest.sortDescriptors = [ sortDescriptors ]
            do {
                try self.images = fetchRequest.execute()
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    private func saveNewData(_ imagesData: ImagesData) {
        // 코어데이터에 저장
        self.persistentContainer.performBackgroundTask { context in
            let images = Images(context: context)
            images.image = imagesData.data
            images.date = imagesData.date
            images.title = imagesData.title
            
            do {
                try context.save()
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    private func deleteData(_ index: Int) {
        self.persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest = Images.fetchRequest()
            let sortDescriptors = NSSortDescriptor(keyPath: \Images.date, ascending: false)
            fetchRequest.sortDescriptors = [ sortDescriptors ]
            do {
                let data: [Images] = try fetchRequest.execute()
                context.delete(data[index])
                try context.save()
                self.modifyInfomation = nil
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    private func modifyData(_ newData: ImagesData) {
        //코어 데이터를 로딩해서  self.items = 로드한 데이터
        guard let index = self.modifyInfomation?.index else { return }
        self.persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest = Images.fetchRequest()
            let sortDescriptors = NSSortDescriptor(keyPath: \Images.date, ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptors]
            do {
                let image = try fetchRequest.execute()
                image[index].date = newData.date
                image[index].title = newData.title
                image[index].image = newData.data
                try context.save()
                self.modifyInfomation = nil
            } catch {
                print(error)
            }
        }
    }
    
    func saveData(newData: ImagesData) {
        if self.modifyInfomation != nil {
            self.modifyData(newData)
        } else {
            self.saveNewData(newData)
        }
    }
}
