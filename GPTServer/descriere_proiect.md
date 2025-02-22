# Elemente relevante incluse in realizarea proiectului

S-a decis realizarea pe cont propriu a unei "alternative" a unei interfete pentru LLM-uri, initial gandit pe API-ul
Anthropic, dar care poate fi usor adaptat pentru orice api, inclusiv OpenAI compatible (cum sunt marea majoritate a
APIurilor de generare de text).

- Se realizeaza actualizarea automata a mesajelor, dupa interogarea API-urilor, precum si stocarea conversatiilor prin
  intermediul bazei de date SQL si ORM-ului furnizat de Asp.Net Core
- Proiectul include toate elementele ensentiale care sa dovedeasca insusirea cunostintelor predate in cadrul cursului de
  Medii de Programare, in speta:
    - Utilizarea unui ORM pentru lucrul cu baza de date
    - Utilizarea unui API extern (REST)
    - Utilizarea unui API intern (prin intermediul unui controller, tot REST)
    - Utilizarea sistemului integrat de autentificare si autorizare
    - Sistem de permissioning pentru restrictionarea modelelor accesibile pe tipuri de utilizatori

- Ce se include in aplicatie:
    - Persistenta chat-uri, mesaje.
    - Selector model AI, cu permissioning
    - Interfata grafica pentru chat, cu multi-conversation management.

## Mentiuni:

- S-a utilizat modelul Anthropic Claude-3.5-Sonnet pentru generarea design-ului pentru interfata grafica a paginii de
  chat (HTML + CSS), fiind ulterior adaptata pentru Razor Pages.

## Documentare (cu privire la ghidul UBB FSEGA pentru utilizarea modelelor AI):

- Am folosit modelul Anthropic Claude-3.5-Sonnet prin:
    - Interfata Claude.ai (pentru generarea de componente web)
    - API-ul Anthropic (Pentru furnizarea unui set mai mare de informatii precum si pentru a modifica system prompt-ul
      pentru a creste calitatea in generari)

- Cu privire la indeplinirea sarcinilor didactice (asimilat "Eseuri si referate"):
    - Am eliminat zonele reduntante adaugate de AI, am identificat si rectificat erori de generare precum:
        - Eliminarea zonelor redundante din design.
        - Pentru modificare usoara UI, am stabilit stilul, si dat exemple specifice. Am eliminat ulterior functiile
          superflue irelevante pentru proiect.