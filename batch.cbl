       IDENTIFICATION DIVISION.
       PROGRAM-ID. BATCHBNK.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANSACTION-FILE ASSIGN TO FILETRANS
                ORGANIZATION IS LINE SEQUENTIAL.
           SELECT MASTER-FILE ASSIGN TO FILEMASTER
                ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD TRANSACTION-FILE.
       01 TRANSACTION-LINE.
           05 NAME-TRANS PIC X(20).
           05 TYPE-TRANS PIC X.
           05 AMOUNT-TRANS PIC 9(4).
       FD MASTER-FILE.
       01 MASTER-RECORD.
           05 MASTER-NAME PIC X(20).
           05 MASTER-BALANCE PIC 9(4).
       WORKING-STORAGE SECTION.
       01 WS-END-TRANS PIC X VALUE 'N'.
       01 WS-END-MASTER PIC X VALUE 'N'.
       01 WS-DATABASE.
           05 DB-RECORD OCCURS 3 TIMES.
               10 DB-NAME PIC X(20).
               10 DB-BALANCE PIC 9(4).
       01 I PIC 9(2).
       01 CLIENT-FOUND PIC X.
       01 NB-CLIENTS PIC 9(2) VALUE 0.

       PROCEDURE DIVISION.
       DEBUT-PROGRAMME.
           DISPLAY "============================".
           DISPLAY "   STARTING BATCH PROCESS   ".
           DISPLAY "============================".
           OPEN INPUT MASTER-FILE.
           MOVE 1 TO I.
           READ MASTER-FILE
               AT END MOVE 'Y' TO WS-END-MASTER
           END-READ.
           PERFORM UNTIL WS-END-MASTER = 'Y' OR I > 10
               MOVE MASTER-NAME TO DB-NAME(I)
               MOVE MASTER-BALANCE TO DB-BALANCE(I)
               ADD 1 TO NB-CLIENTS
               ADD 1 TO I
               READ MASTER-FILE
                   AT END MOVE 'Y' TO WS-END-MASTER
               END-READ
           END-PERFORM.
           CLOSE MASTER-FILE.
           DISPLAY "-> " NB-CLIENTS " clients loaded from DB".

           OPEN INPUT TRANSACTION-FILE.
           READ TRANSACTION-FILE
               AT END MOVE 'Y' TO WS-END-TRANS
           END-READ.

           PERFORM LINE-TREATMENT UNTIL WS-END-TRANS = 'Y'.
           CLOSE TRANSACTION-FILE.

           DISPLAY " ".
           DISPLAY "---SAVING NEW BALANCES---".
           OPEN OUTPUT MASTER-FILE.

           PERFORM VARYING I FROM 1 BY 1 UNTIL I > NB-CLIENTS
               MOVE DB-NAME(I) TO MASTER-NAME
               MOVE DB-BALANCE(I) TO MASTER-BALANCE
               WRITE MASTER-RECORD
               DISPLAY DB-NAME (I) " : " DB-BALANCE (I) " EUR"
           END-PERFORM.
           CLOSE MASTER-FILE.
           DISPLAY "-> DATABASE UPDATED ! ".
           STOP RUN.

       LINE-TREATMENT.
           MOVE 'N' TO CLIENT-FOUND.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
               IF NAME-TRANS = DB-NAME(I)
                  MOVE 'Y' TO CLIENT-FOUND
                  IF TYPE-TRANS = 'D' OR TYPE-TRANS = 'd'
                     ADD AMOUNT-TRANS TO DB-BALANCE(I)
                     DISPLAY "[OK] DEPOSIT " AMOUNT-TRANS " FOR "
                     NAME-TRANS
                  ELSE
                     IF TYPE-TRANS = 'W' OR TYPE-TRANS = 'w'
                        IF AMOUNT-TRANS > DB-BALANCE(I)
                           DISPLAY "[REJECTED]" NAME-TRANS
                           " : INSUFFICIENT FUNDS!"
                        ELSE
                           SUBTRACT AMOUNT-TRANS FROM DB-BALANCE(I)
                           DISPLAY "[OK] WITHDRAW " AMOUNT-TRANS
                           " FOR " NAME-TRANS
                        END-IF
                     END-IF
                  END-IF
               END-IF
           END-PERFORM.
           IF CLIENT-FOUND = 'N'
           DISPLAY "[ERROR] CLIENT NOT IN DATABASE : " NAME-TRANS
           END-IF.
           READ TRANSACTION-FILE
               AT END MOVE 'Y' TO WS-END-TRANS
           END-READ.
