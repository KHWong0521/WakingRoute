//
//  RouteListView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 28/12/2023.
//

import SwiftUI
import CoreData

struct RouteListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Route.name, ascending: true)],
        animation: .default)
    
    private var routes: FetchedResults<Route>
    
    @State var showAddRouteView : Bool = false
    @State var showLoginView : Bool = false
    @State var isLoggedIn : Bool = false
    @State var isSigningUp : Bool = false
    @State var username : String = ""
    @State var showAlert : Bool = false
    @State var alertTitle : String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(routes) { route in
                    NavigationLink {
                        DetailView(route: route)
                    } label: {
                        if let image = route.image,
                            let image = UIImage(data: image) {

                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 100.0, height: 80.0)

                        }
                        Text("\(route.name!)")
                    }
                }
                .onDelete(perform: deleteRoutes)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showLoginView = true
                    }) {
                        Label("Add Item", systemImage: "person.circle")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddRouteView = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }

            }
            .navigationBarTitle(
                Text("Route List")
            )
            .sheet(isPresented: $showLoginView, content: {
                SignUpAndLoginView(showLoginView: $showLoginView, isLoggedIn: $isLoggedIn, isSigningUp: $isSigningUp, username: $username, alertTitle: $alertTitle, showAlert: $showAlert)
            })
            .sheet(isPresented: $showAddRouteView, content: {
                AddRouteView(showAddRouteView: $showAddRouteView)
            })
        }
    }

    private func deleteRoutes(offsets: IndexSet) {
        withAnimation {
            offsets.map { routes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    RouteListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
