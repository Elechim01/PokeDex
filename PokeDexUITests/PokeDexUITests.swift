//
//  PokeDexUITests.swift
//  PokeDexUITests
//
//  Created by Michele Manniello on 25/03/26.
//

import XCTest

final class PokeDexUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Ferma i test al primo errore per non perdere tempo
        continueAfterFailure = false
        app.launch()
    }

    /// UI TEST 1: Verifica la ricerca e il filtraggio dei Pokémon.
    func test_search_filtering_works() {
        let searchField = app.textFields["Cerca Pokémon"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "La barra di ricerca dovrebbe essere visibile")
        
        searchField.tap()
        searchField.typeText("Bulbasaur")
        
        // Verifichiamo che appaia la cella con il nome giusto
        let pokemonCell = app.staticTexts["Bulbasaur"]
        XCTAssertTrue(pokemonCell.exists, "Dovrebbe mostrare Bulbasaur dopo la ricerca")
    }

    /// UI TEST 2: Verifica la navigazione verso il dettaglio al tap sulla riga.
    func test_navigation_to_detail() {
        // 1. Cerchiamo il bottone della riga
        let pokemonButton = app.buttons["pokemonRow_bulbasaur"]
        
        // 2. Aspetta che appaia
        XCTAssertTrue(pokemonButton.waitForExistence(timeout: 20), "Il tasto di Bulbasaur non è apparso")
        
        // 3. Tap (ora che è un bottone, Xcode non fallirà)
        pokemonButton.tap()
        
        // 4. Verifica navigazione
        let abilitiesLabel = app.staticTexts["Abilità"]
        XCTAssertTrue(abilitiesLabel.waitForExistence(timeout: 10), "Schermata dettaglio non caricata")
    }

    /// UI TEST 3: Verifica che le sezioni collassabili funzionino.
    func test_collapsible_sections_expansion() {
        // Entriamo nel dettaglio del primo Pokémon
        let pokemonButton = app.buttons["pokemonRow_bulbasaur"]
        
        // 2. Aspetta che appaia
        XCTAssertTrue(pokemonButton.waitForExistence(timeout: 20), "Il tasto di Bulbasaur non è apparso")
        
        // 3. Tap (ora che è un bottone, Xcode non fallirà)
        pokemonButton.tap()
        
        // Cerchiamo il bottone delle Abilità
        let abilitiesButton = app.buttons["Abilità"]
        XCTAssertTrue(abilitiesButton.exists)
        
        // Tap per espandere (requisito: inizialmente è collassato)
        abilitiesButton.tap()
        
        // Qui verifichiamo che appaia un elemento della lista (es. un pallino o testo dell'abilità)
        // Usiamo un predicato per cercare un testo che inizia con il pallino dell'elenco puntato
        let bulletPoint = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH '•'")).firstMatch
        XCTAssertTrue(bulletPoint.exists, "La lista delle abilità dovrebbe essere visibile dopo il tap")
    }
}
