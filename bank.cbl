       IDENTIFICATION DIVISION.
       PROGRAM-ID. MINIBANK.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANSACTION-FILE ASSIGN TO "transactions.txt"
                ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD TRANSACTION-FILE.
       01 TRANSACTION-LINE.
           05 NAME-TRANS PIC X(20).
           05 TYPE-TRANS PIC X.
           05 AMOUNT-TRANS PIC 9(4).
       WORKING-STORAGE SECTION.
       01 WS-NAME PIC X(20).
       01 WS-TYPE PIC X VALUE SPACE.
           88 VALID-ACTION VALUE 'D', 'd', 'W', 'w'.
       01 WS-AMOUNT PIC 9(4).
       01 VALID-AMOUNT-FLAG PIC X VALUE 'N'.
       01 WS-DISPLAY-AMOUNT PIC ZZZ9.

       PROCEDURE DIVISION.
       DEBUT-PROGRAMME.
           DISPLAY "==========================".
           DISPLAY "   WELCOME TO MINI BANK   ".
           DISPLAY "==========================".
           DISPLAY "Enter your name: ".
           ACCEPT WS-NAME.
           PERFORM UNTIL VALID-ACTION
                DISPLAY "Deposit (D) or Withdrawal (W)? "
                ACCEPT WS-TYPE
                IF NOT VALID-ACTION
                    DISPLAY "->ERROR: Please type D or W."
                END-IF
           END-PERFORM.

           PERFORM UNTIL VALID-AMOUNT-FLAG = 'Y'
                DISPLAY "Enter amount (numbers only, max 9999): "
                ACCEPT WS-AMOUNT
                IF WS-AMOUNT IS NUMERIC
                    MOVE 'Y' TO VALID-AMOUNT-FLAG
                ELSE
                    DISPLAY "->ERROR: Invalid amount. Numbers only !"
                END-IF
           END-PERFORM.
           MOVE WS-AMOUNT TO WS-DISPLAY-AMOUNT.
           DISPLAY " ".
           DISPLAY "--RECEIVED---".
           DISPLAY "Client : " WS-NAME.
           DISPLAY "Action : " WS-TYPE.
           DISPLAY "Amount : " WS-DISPLAY-AMOUNT " EUR".
           DISPLAY "--------------".

           OPEN EXTEND TRANSACTION-FILE.
           MOVE WS-NAME TO NAME-TRANS.
           MOVE WS-TYPE TO TYPE-TRANS.
           MOVE WS-AMOUNT TO AMOUNT-TRANS.

           WRITE TRANSACTION-LINE.
           CLOSE TRANSACTION-FILE.

           DISPLAY " ".
           DISPLAY "->Transaction saved".

           STOP RUN.
