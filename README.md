# PokéDex App - Clean Architecture & SwiftUI

Un'applicazione iOS moderna che utilizza la **PokeAPI** per visualizzare un elenco di Pokémon, con dettagli approfonditi, paginazione e ricerca.

## 🛠 Architettura
L'app segue i principi della **Clean Architecture** suddivisa in tre layer principali:

- **Domain Layer**: Contiene le `Entities` (modelli di business puri) e gli `Use Cases`. È totalmente indipendente da framework esterni.
- **Data Layer**: Gestisce il networking, i `DTO` (Data Transfer Objects) e i `Mappers` per convertire i dati API in entità di dominio.
- **Presentation Layer**: Implementato in **SwiftUI** seguendo il pattern **MVVM + Coordinator**.
  - Il `Coordinator` gestisce il flusso di navigazione.
  - I `ViewModel` gestiscono lo stato della UI utilizzando `Async/Await`.

## 🚀 Caratteristiche Principali
- **Paginazione**: Caricamento automatico di nuovi Pokémon allo scorrimento della lista.
- **Ricerca Real-time**: Filtro immediato della lista tramite SearchBar personalizzata.
- **UI Dettaglio**: Sezioni collassabili per Abilità e Mosse (requisito tecnico).
- **Networking**: Utilizzo di `URLSession` con la nuova sintassi `async/await`.

## 🧪 Testing Strategy
Il progetto include una suite di test completa per garantire la stabilità:
- **Unit Tests**: Test dei ViewModel (`Home` e `Detail`) utilizzando **Stub JSON** per simulare le risposte dell'API senza latenza di rete.
- **UI Tests**: 3 flussi utente automatizzati (Ricerca, Navigazione, Espansione sezioni) per verificare l'integrità della User Experience.

## 📌 Requisiti Tecnici
- iOS 15.0+
- Xcode 16.4+
- Swift 5.10+

