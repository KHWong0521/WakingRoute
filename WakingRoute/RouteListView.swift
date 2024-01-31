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

    var body: some View {
        NavigationView {
            List {
                ForEach(routes) { route in
                    NavigationLink {
                        DetailView(route: route)
                    } label: {
                        Text("\(route.name!)")
                    }
                }
                .onDelete(perform: deleteRoutes)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAddRouteView = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddRouteView, content: {
                        AddRouteView(showAddRouteView: $showAddRouteView)
                    })
                }
            }
            .navigationBarTitle(
                Text("Route List")
            )
        }
    }

    func loadDefaultRoute(_ name: String, _ initialLat: Double, _ initialLon: Double, _ destinationLat: Double, _ destinationLon: Double) {
        withAnimation {
            // let newRoute = Route(context: viewContext)
            // newRoute.initial = Date()

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

    private func deleteRoutes(offsets: IndexSet) {
        withAnimation {
            offsets.map { routes[$0] }.forEach(viewContext.delete)

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
}

#Preview {
    RouteListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
