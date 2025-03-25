//
//  ApiNewsRepository.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
import CoreData

class NewsDiskDataSource {
    private var context: NSManagedObjectContext!
    
    func setNSManagedObjectContext(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getNews() -> [News] {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        do {
            let newsEntities = try context.fetch(fetchRequest)
            return newsEntities.map {
                News(imageURL: $0.image, title: $0.title, description: $0.descripcion, favorite: $0.favorite)
            }
        } catch {
            print("Error al obtener noticias: \(error)")
            return []
        }
    }

    func saveNewsList(newsList: [News]) {
        for news in newsList {
            if !newsExists(title: news.title) {
                let newsEntity = NewsEntity(context: context)
                newsEntity.image = news.imageURL
                newsEntity.title = news.title
                newsEntity.descripcion = news.description
                newsEntity.favorite = false
            }
        }
        do {
            try context.save()
        } catch {
            print("Error al guardar noticias: \(error)")
        }
    }

    func newsExists(title: String?) -> Bool {
        guard let title = title else { return false }
        
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error al verificar existencia de noticia: \(error)")
            return false
        }
    }

    func updateNews(news: News) {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", news.title ?? "")
        do {
            let result = try context.fetch(fetchRequest).first
            if let newsEntity = result {
                newsEntity.image = news.imageURL
                newsEntity.descripcion = news.description
                newsEntity.favorite = news.favorite
                try context.save()
            }
        } catch {
            print("Error al actualizar noticia: \(error)")
        }
    }

    func deleteNews(news: News) {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", news.title ?? "")
        do {
            if let newsEntity = try context.fetch(fetchRequest).first {
                context.delete(newsEntity)
                try context.save()
            }
        } catch {
            print("Error al eliminar noticia: \(error)")
        }
    }
    
    func deleteAllNews() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NewsEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            context.reset()
        } catch {
            print("Error al eliminar todas las películas: \(error)")
        }
    }
}


