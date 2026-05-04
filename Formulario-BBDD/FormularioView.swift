import SwiftUI

import Supabase

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://jjagqkzqirijhwonhbzf.supabase.co")!,
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqYWdxa3pxaXJpamh3b25oYnpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc1MzczNDYsImV4cCI6MjA5MzExMzM0Nn0.aDjbZNJxfV_z3iGp-XE5-GtMqkJHN_vqR81kAA70iCQ"
)

struct FormularioView: View {
    
    @State var titulo: String = ""
    @State var descripcion: String = ""
    @State var categoria: String = ""
    @State var prioridad = 0
    @State var email: String = ""
    let prioridades = ["1", "2", "3", "4", "5"]
    
    @State private var isSending = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToSuccess = false
    
    var tituloValido: Bool {
        titulo.count >= 5 && titulo.count <= 60
    }
    
    var descripcionValido: Bool {
        descripcion.count >= 20 && descripcion.count <= 500
    }
    
    var emailValido: Bool {
        email.contains("@") && email.contains(".")
    }
    
    var asterisco = Text("*").foregroundColor(.red)

    var body: some View {
        NavigationView{
            VStack {
                
                Form {
                    Section(header: Text("Datos \(asterisco)")){
                        TextField("Título", text: $titulo)
                        if !tituloValido && !titulo.isEmpty {
                            Text("⚠️ El titulo debe tener entre 5 y 60 caracteres")
                                .font(.caption.italic())
                                .foregroundColor(.red)
                        }
                        
                        TextField("Descripción", text: $descripcion)
                        if !descripcionValido && !descripcion.isEmpty {
                            Text("⚠️ La descripcion debe tener entre 20 y 500 caracteres")
                                .font(.caption.italic())
                                .foregroundColor(.red)
                        }
                        
                        TextField("Categoria", text: $categoria)
                    }
                    
                    Section(header: Text("Prioridad \(asterisco)")){
                        Picker("Prioridad", selection: $prioridad) {
                            ForEach(prioridades.indices, id: \.self) { i in
                                Text(self.prioridades[i])
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("Contacto \(asterisco)")) {
                        TextField("Email", text: $email)
                        if !emailValido && !email.isEmpty {
                            Text("⚠️ El email debe tener un formato valido")
                                .font(.caption.italic())
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    enviarFormulario()
                } label: {
                    Text(isSending ? "Enviando..." : "Enviar Formulario")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                }
                .disabled(!tituloValido || !descripcionValido || !emailValido || categoria.isEmpty || isSending)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                
                
                NavigationLink(
                    destination: PantallaContinuar(
                        userTitulo: titulo,
                        userDescripcion: descripcion,
                        userCategoria: categoria,
                        userPrioridad: prioridad,
                        userEmail: email
                    ),
                    isActive: $navigateToSuccess
                ) {
                    EmptyView()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Formulario").bold()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .alert("Error", isPresented: $showError) {
                Button("Reintentar") {
                    enviarFormulario()
                }
                Button("Cancelar", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    struct Formulario: Encodable {
        let titulo: String
        let descripcion: String
        let categoria: String
        let prioridad: Int
        let email: String
    }
    
    func enviarFormulario() {
        isSending = true

        let form = Formulario(
            titulo: titulo,
            descripcion: descripcion,
            categoria: categoria,
            prioridad: prioridad,
            email: email
        )

        Task {
            do {
                try await supabase
                    .from("formularios")
                    .insert(form)
                    .execute()

                DispatchQueue.main.async {
                    self.navigateToSuccess = true
                    self.isSending = false
                }

            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    self.isSending = false
                }

                print("ERROR REAL:", error) 
            }
        }
    }
    }



#Preview {
    FormularioView()
}
