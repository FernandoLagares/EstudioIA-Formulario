


import SwiftUI

struct PantallaContinuar: View {
    
    let userTitulo: String
    let userDescripcion: String
    let userCategoria: String
    let userPrioridad:Int
    let userEmail: String
    let Prioridades = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        
        VStack {
            
            Text("Formulario").font(.title).bold()
            
            Text("enviado con exito").font(Font.title3.bold()).foregroundColor(Color.green)
            
            
            InformationView(userTitulo: userTitulo, userDescripcion: userDescripcion, userCategoria: userCategoria, userPrioridad: userPrioridad, userEmail: userEmail)
            
            aceptarFormularioButton()   
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(UIColor.systemGroupedBackground))
                
            
        
    }
}

struct InformationView:View {
    
    let userTitulo: String
    let userDescripcion: String
    let userCategoria: String
    let userPrioridad:Int
    let userEmail: String
    let Prioridades = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        VStack {
            Text("Titulo: \(userTitulo)").font(.headline).frame(maxWidth: .infinity, maxHeight: 150)
            Text("Descripción: \(userDescripcion)").font(.headline).frame(maxWidth: .infinity, maxHeight:150)
            Text("Categoría: \(userCategoria)").font(.headline).frame(maxWidth: .infinity, maxHeight: 150)
            Text("Prioridad: \(userPrioridad)").font(.headline).frame(maxWidth: .infinity, maxHeight: 150)
            Text("Email: \(userEmail)").font(.headline).frame(maxWidth: .infinity, maxHeight: 150)
        }.frame(maxWidth: .infinity, maxHeight: 300).navigationBarBackButtonHidden(true)

    }
}	

struct aceptarFormularioButton:View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
                    dismiss()
                } label: {
                    Text("Aceptar")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)
        

    }
}

#Preview {
    PantallaContinuar(userTitulo: "", userDescripcion: "", userCategoria: "", userPrioridad: 0, userEmail: "")
}
