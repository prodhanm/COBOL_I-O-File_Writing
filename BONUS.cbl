        IDENTIFICAITON DIVISION.
        PROGRAM-ID. BONUS.
        
        ENVIRONMENT DIVISION.
        * This is area where the files that are being 
        * configured are defined.
        INPUT-OUTPUT SECTION.
        FILE CONTROL.
            SELECT INPUT-BONUS ASSIGN TO INBONUS
                FILE STATUS IS WS-INBONUS-STATUS.
            SELECT OUTPUT-BONUS ASSIGN TO OUTBONUS
                FILE STATUS IS WS-OUTBONUS-STATUS.

        DATA DIVISION.
        FILE SECTION.

        FD INPUT-BONUS
            RECORDING MODE IS F
            BLOCK CONTAINS 80 RECORDS
            DATA RECORD IS FD-INBONUS-REC.
        01 FD-INBONUS-REC.                  PIC X(80).

        FD OUTPUT-BONUS
            RECORDING MODE IS F
            BLOCK CONTAINS 80 RECORDS
            DATA RECORD IS FD-OUTBONUS-REC.
        01 FD-OUTBONUS-REC.                  PIC X(80).

        WORKING-STORAGE SECTION.
        01 FILLER                           PIC X(37)  VALUE
            'BEGIN WORKING STORAGE FOR BONUS '.
        01 WS-INBONUS-STATUS                PIC 9(02)  VALUE ZEROS.
        01 WS-OUTBONUS-STATUS               PIC 9(02)  VALUE ZEROS.
        * 'VALUE ZEROES' are how you initialize a variable in COBOL.
        * The next section is the ACCUMULATORS, which is how we defined
        * the records that are to be input and output.

        01 W01-ACCUMULATORS.
            05 WS-REC-IN                    PIC S9(04) COMP VALUE ZEROS.
            05 WS-REC-OUT                   PIC S9(04) COMP VALUE ZEROS.
        
        01 W02-SWITCHES.
            05 WS-INBONUS-EOF-SW            PIC X(01)   VALUE 'N'.
        * INPUT and OUTPUT layouts as the rest of the variables in WS.

        01 WS-INBONUS-REC.
            05 WS-IN-STATE-CODE             PIC X(02).
            05 WS-IN-LAST-NAME              PIC X(20).
            05 WS-IN-FIRST-NAME             PIC X(15).
            05 WS-IN-MID-INIT               PIC X(01).
            05 WS-IN-BONUS-AMT              PIC 9(9).
            05 WS-IN-FED-EXEMPT-IND         PIC X(01).
            05 WS-IN-ST-EXEMPT-IND          PIC X(01).
            05 WS-IN-FILLER                 PIC X(31).
        
        01 WS-OUTBONUS-REC.
            05 WS-OUT-STATE-CODE            PIC X(02).
            05 WS-OUT-LAST-NAME             PIC X(20).
            05 WS-OUT-FIRST-NAME            PIC X(15).
            05 WS-OUT-MID-INIT              PIC X(01).
            05 WS-OUT-BONUS-AMT             PIC 9(7)V99.
            05 WS-OUT-FED-EXEMPT-IND        PIC X(01).
            05 WS-OUT-ST-EXEMPT-IND         PIC X(01).
            05 WS-OUT-FILLER                PIC X(31).

        PROCEDURE DIVISION.
        * This is the main part of the program where 
        * the logic is written.

        P0100-MAINLINE.
            PERFORM P0200-INITIALIZES       THRU P0299-EXIT.

            PERFORM P0300-PROCESS-INPUT     THRU P0399-EXIT
                UNTIL WS-INBONUS-EOF-SW = 'Y'.
            * This is the loop that reads the input until the
            * end of the file.

            PERFORM P0400-WRAP-UP           THRU P0499-EXIT

            STOP RUN.

        P0199-EXIT.
            EXIT. 
