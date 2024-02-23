//
//  ContentView.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - Properties
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    //MARK: - Feching data
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - Functions
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Main View
                VStack {
                    //MARK: - Header
                    
                    HStack(spacing: 10) {
                        //Tilte
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()

                        //Edit Btn
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )

                        //Appearance Btn
                        Button(){
                            //Toogle Appearance
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }

                    }//: HStack
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer(minLength: 80)
                    //MARK: - New task Button
                    
                    Button {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    //MARK: - Task
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }//: Loop
                        .onDelete(perform: deleteItems)
                    }//: List
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }//: VStack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))

                //MARK: - New task item

                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5
                    )
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }//: VZtack
//            .onAppear(){
//                UITableView.appearance().backgroundColor = UIColor.clear
//            }
            .navigationTitle("Daily Tasks")
            .toolbarTitleDisplayMode(.large)
            .toolbar(.hidden)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    EditButton()
//                }
//            }//: Toolbar
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            .background(backgroundGradinet.ignoresSafeArea(.all))
        }//: Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
