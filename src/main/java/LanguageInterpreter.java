import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.Reader;

import java_cup.runtime.Symbol;

public class LanguageInterpreter {
    
    private final LanguageParser parser;
    
    public LanguageInterpreter(Reader reader) {
        LanguageLexer lexer = new LanguageLexer(reader);
        parser = new LanguageParser(lexer);
    }
    
    public void interpret() throws Exception {
        Symbol result = parser.parse();
        System.out.println("Parsing completed successfully");
    }
    
    public static void main(String[] args) throws FileNotFoundException {
        Reader reader;
        if (args.length == 1) {
            File input = new File(args[0]);
            if (!input.canRead()) {
                System.err.println("Error: could not read [" + input + "]");
            }
            reader = new FileReader(input);
        } else {
            reader = new InputStreamReader(System.in);
        }
        
        LanguageInterpreter interpreter = new LanguageInterpreter(reader);
        
        try {
            interpreter.interpret();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
