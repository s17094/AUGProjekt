import java_cup.runtime.Symbol;

%%

%class LanguageLexer
%cup
%implements sym

%{
    StringBuilder string = new StringBuilder();

    private Symbol symbol(int symbol) {
        return new Symbol(symbol);
    }

    private Symbol symbol(int symbol, Object value) {
        return new Symbol(symbol, value);
    }

%}

Identifier = [:jletter:][:jletterdigit:]*

LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]

/* string and character literals */
StringCharacter = [^\r\n\"\\]
DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING

%%

<YYINITIAL> {

    /* keywords */
    "if"                           { return symbol(IF); }
    "then"                         { return symbol(THEN); }
    "else"                         { return symbol(ELSE); }
    "begin"                        { return symbol(BEGIN); }
    "end"                          { return symbol(END); }
    "or"                           { return symbol(OR); }
    "and"                          { return symbol(AND); }
    "not"                          { return symbol(NOT); }
    "for"                          { return symbol(FOR); }
    "to"                           { return symbol(TO); }
    "do"                           { return symbol(DO); }
    "print"                        { return symbol(PRINT); }
    "break"                        { return symbol(BREAK); }
    "continue"                     { return symbol(CONTINUE); }
    "exit"                         { return symbol(EXIT); }
    "length"                       { return symbol(LENGTH); }
    "position"                     { return symbol(POSITION); }
    "concatenate"                  { return symbol(CONCATENATE); }
    "substring"                    { return symbol(SUBSTRING); }

    /* operators */
    "+"                            { return symbol(PLUS); }
    "-"                            { return symbol(MINUS); }
    "*"                            { return symbol(MULT); }
    "/"                            { return symbol(DIV); }
    "%"                            { return symbol(MOD); }
    "("                            { return symbol(LPAREN); }
    ")"                            { return symbol(RPAREN); }
    ","                            { return symbol(COMMA); }
    "="                            { return symbol(EQ); }
    "<"                            { return symbol(LT); }
    "<="                           { return symbol(LTEQ); }
    ">"                            { return symbol(GT); }
    ">="                           { return symbol(GTEQ); }
    "<>"                           { return symbol(NOTEQ); }
    "=="                           { return symbol(EQEQ); }
    "!="                           { return symbol(NOTEQEQ); }
    ";"                            { return symbol(SEMICOLON); }

    /* boolean literals */
    "true"                         { return symbol(TRUE); }
    "false"                        { return symbol(FALSE); }

     /* number */
    {DecIntegerLiteral}            { return symbol(NUM,Integer.valueOf(yytext())); }

    /* string literal */
    \"                             { yybegin(STRING); string.setLength(0); }

    /* assign */
    ":="                           { return symbol(ASSIGN); }

    /* whitespace */
    {WhiteSpace}                   { /* ignore */ }

    /* identifiers */
    {Identifier}                   { return symbol(IDENT, yytext()); }
}

<STRING> {
    \"                             { yybegin(YYINITIAL); return symbol(STRING, string.toString()); }
    {StringCharacter}+             { string.append( yytext() ); }
}

