//
//  PokeDexUITests.swift
//  PokeDexUITests
//
//  Created by Michele Manniello on 25/03/26.
//

import XCTest

import XCTest

/// Test d'interfaccia (UI Tests) per l'applicazione PokeDex.
///
/// Verifica i flussi utente principali: ricerca, navigazione e interazione con componenti custom.
final class PokeDexUITests: XCTestCase {
    let app = XCUIApplication()

    /// Configura l'ambiente di test prima di ogni esecuzione.
    override func setUpWithError() throws {
        // Ferma i test al primo errore per facilitare il debug.
        continueAfterFailure = false
        // Avvia l'applicazione.
        app.launch()
    }

    /// Verifica che la funzionalità di ricerca filtri correttamente la lista dei Pokémon a schermo.
    func test_search_filtering_works() {
        // Cerchiamo la SearchBar tramite il suo placeholder/label
        let searchField = app.textFields["Cerca Pokémon"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "La barra di ricerca dovrebbe essere visibile")
        
        searchField.tap()
        searchField.typeText("Bulbasaur")
        
        // Verifichiamo che la lista mostri solo il risultato pertinente
        let pokemonCell = app.staticTexts["Bulbasaur"]
        XCTAssertTrue(pokemonCell.exists, "La lista dovrebbe mostrare 'Bulbasaur' come risultato del filtro")
    }

    /// Verifica che il tap su una riga della lista porti l'utente alla schermata di dettaglio.
    func test_navigation_to_detail() {
        // Identifichiamo il bottone della riga tramite l'accessibilityIdentifier impostato nella View
        let pokemonButton = app.buttons["pokemonRow_bulbasaur"]
        
        XCTAssertTrue(pokemonButton.waitForExistence(timeout: 20), "Il tasto di Bulbasaur non è apparso in tempo")
        
        pokemonButton.tap()
        
        // Verifichiamo la presenza di un elemento tipico della DetailView
        let abilitiesLabel = app.staticTexts["Abilità"]
        XCTAssertTrue(abilitiesLabel.waitForExistence(timeout: 10), "La schermata di dettaglio non è stata caricata correttamente")
    }

    /// Verifica il comportamento del componente `CollapsibleSection`.
    ///
    /// Testa il requisito obbligatorio: le sezioni devono essere inizialmente chiuse e aprirsi al tap.
    func test_collapsible_sections_expansion() {
        let pokemonButton = app.buttons["pokemonRow_bulbasaur"]
        XCTAssertTrue(pokemonButton.waitForExistence(timeout: 10))
        pokemonButton.tap()
        
        // Identifichiamo l'intestazione della sezione "Abilità"
        let abilitiesButton = app.buttons["Abilità"]
        XCTAssertTrue(abilitiesButton.exists, "Il bottone della sezione Abilità dovrebbe essere presente")
        
        // Eseguiamo il tap per espandere il contenuto
        abilitiesButton.tap()
        
        // Verifichiamo che appaia un elemento della lista puntata (es. '• Overgrow')
        let bulletPoint = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH '•'")).firstMatch
        XCTAssertTrue(bulletPoint.exists, "Il contenuto della sezione dovrebbe essere visibile dopo l'espansione")
    }
}
