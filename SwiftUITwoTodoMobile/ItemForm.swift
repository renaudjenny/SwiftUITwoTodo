import SwiftUI

struct ItemForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @State private var title = ""

    var body: some View {
        Form {
            TextField("Title", text: $title)
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: { Text("Cancel") }
                Spacer()
                Button {
                    let newItem = Item(context: viewContext)
                    newItem.timestamp = Date()
                    newItem.isChecked = false
                    newItem.title = title

                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: { Text("Save") }
            }
        }
    }
}

#if DEBUG
struct ItemForm_Previews: PreviewProvider {
    static var previews: some View {
        ItemForm()
    }
}
#endif
