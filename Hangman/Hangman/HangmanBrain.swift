struct HangmanBrain {
    private(set) var guessCount: Int = 6
    
    var guessedLetterDisplayText: String {
        return hiddenWord?.reduce(""){ $0 + (storedUserInput.contains(String($1)) ? String($1) : "_ ") } ?? ""
    }
    
    // MARK: Internal Functions
    
    mutating func update(with guess: String) -> GameStatus {
        storedUserInput.append(guess)
        guard let word = hiddenWord else { fatalError("A hidden word is needed at this point") }
        if !word.contains(guess) {
            guessCount -= 1
        }
        if playerIsVictorious { return .victory }
        if playerIsDefeated { return .defeat }
        return .inProgess
    }
    
    mutating func setHiddenWord(to word: String) {
        hiddenWord = word.uppercased()
    }

    func guessStatus(from guess: String) -> GuessStatus {
        let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        guard alphabet.contains(guess) else { return .invalidLetter }
        guard !storedUserInput.contains(guess) else { return .alreadyGuessed }
        return .valid
    }

    
    // MARK: Private Variables
    
    private var storedUserInput: [String] = []
    
    private var hiddenWord: String?
    
    // Mark: Private Functions
    
    private var playerIsVictorious: Bool {
        guard let word = hiddenWord else { fatalError("A hidden word is needed at this point") }
        return Set(word) == Set(storedUserInput.map{ Character($0) })
    }
    
    private var playerIsDefeated: Bool {
        return guessCount == 0
    }
}

enum GameStatus {
    case inProgess
    case victory
    case defeat
}

enum GuessStatus {
    case valid
    case alreadyGuessed
    case invalidLetter
    case outOfGuesses
}
