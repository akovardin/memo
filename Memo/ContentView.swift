//
//  ContentView.swift
//  Memo
//
//  Created by Artem Kovardin on 25.04.2020.
//  Copyright © 2020 Artem Kovardin. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var todo = ""
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: []) var todos: FetchedResults<Todo>
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Task", text: $todo).padding(.all, 20)
                    Button(action: {
                       
                        guard self.todo != "" else {return}
                        
                        let todo = Todo(context: self.managedObjectContext)
                        todo.text = self.todo
                        todo.done = false
                        todo.id = UUID()
                        
                        do {
                            try self.managedObjectContext.save()
                            self.todo = ""
                            print("rder saved")
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    }){
                        Text("Add Task")
                    }.padding(.all, 20)
                }
                List {
                    ForEach(todos) { todo in
                        HStack {
                            Text(todo.text!)
                            Spacer()
                            if todo.done {
                                Button(action: {
                                   self.managedObjectContext.delete(todo)
                                }){
                                    Text("Remove")
                                    .foregroundColor(.blue)
                                }
                            } else {
                                Button(action: {
                                    todo.done = true
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                }){
                                    Text("Complete")
                                    .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Tasks")
                .font(.largeTitle))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return ContentView().environment(\.managedObjectContext, context)
    }
}
