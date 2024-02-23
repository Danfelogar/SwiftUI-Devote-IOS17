//
//  NewTaskItemView.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI

struct NewTaskItemView: View {
    //MARK: - Properties
    @AppStorage("isDarkMode") private var isDarMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    @Binding  var isShowing: Bool
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    //MARK: - Functions
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    //MARK: - Body
    var body: some View {
        VStack{
            Spacer()

            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundStyle(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .clipShape(RoundedRectangle(cornerRadius:  10))
                
                Button {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                } label: {
                    Spacer()
                    
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
                .padding()
                .font(.headline)
                .foregroundStyle(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .clipShape(RoundedRectangle(cornerRadius:  10))
            }//: VStack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .clipShape(RoundedRectangle(cornerRadius:  10))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }//: VStack
        .padding()
    }
}

#Preview { NewTaskItemView(isShowing: .constant(true)) }
