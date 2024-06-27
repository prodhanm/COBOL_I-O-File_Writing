The objective of this program, is to take the input file of an object data file and output it in the systems output by writing it as an output file. Note, that the program, has not written out a file, but written it to the system, thus we see:

            OUTBONUS  DD  SYSOUT=*
            SYSOUT    DD  SYSOUT=*

That snippet of code from the JCL compile file will write out the INBONUS input to the OUTBONUS output.

There are some aspects of the COBOL program that we should understand.

            IDENTIFICAITON DIVISION.
            PROGRAM-ID. BONUS.

Here the PROGRAM-ID should recognize the programmer. The reason why the programmers name is not there, is 
because, this is a code reference file. 

It has been in my experience, that there not many COBOL codes out there. It is still a language that is used today and has some meaning behind it. For, example, it is used heavily in the financial industry, especially within the Banking industry. Many of the world's largest banks, such as JP Morgan Chase, PNC Bank, Citi Corporation Banks, Bank of Montreal (BMO), etc., use COBOL to maintain day to day banking activity, the use of ATM machines and its upkeep, and maintain customer information. However, we should note the highlights of the program, such as the Environment Division, Data Division and the Procedure Division.

In the Environment Division, we defined the INBONUS input file and the OUTBONUS output file. THis is so that the program understands, what file we are focusing on, which is the INPUT-BONUS/OUTPUT-BONUS file. Thus, if read as how they are configured, the INPUT-BONUS file is assigned as WS-INBONUS-STATUS or WS-OUTBONUS-STATUS that is assigned from OUTPUT-BONUS. 

Configuring the files allows for the input output files and other sections of the files to then allocate memory based on thier PIC clauses. The purpose of the PIC clause is the assign how many bytes should a variable or an object should have. (check for specific definitions)
Certain aspects of mental math need to apply here for the PIC clauses to workout. 

The other aspect of the DATA division, is that it also allows for the VALUE clause to be used to initialize values, such as the following 2 examples: 

    01 W01-ACCUMULATORS.
        05 WS-REC-IN    PIC S9(04) COMP VALUE ZEROS.
        05 WS-REC-OUT   PIC S9(04) COMP VALUE ZEROS.

This example is equivalent to setting a variable to equal to zero, as to then start as a placeholder until, each actual values that it reads, and transfers the data to the input file, which will then output to the system file. Another example is the use of boolean to initialize the value to 'N'. This is similar to setting the value to false. See below:

    01 W02-SWITCHES.
        05 WS-INBONUS-EOF-SW   PIC X(01)   VALUE 'N'.


This same code is read on the Procedure Division in a PERFORM-THRU for loop. 

    PERFORM P0300-PROCESS-INPUT     THRU P0399-EXIT
        UNTIL WS-INBONUS-EOF-SW = 'Y'.

For more understanding of what the THRU clause does, please refer to COBOL documentation at:
https://www.mainframestechhelp.com/tutorials/cobol/basic-verbs.htm

Just to emphasize the boolean, the Perform clause takes the input and takes it to its exit via the THRU clause UNTIL the swtich statement becomes true, aka 'Y' from its initial value of 'N'.

Once the record is looped via the PERFORM-THRU for loop, it then stops the program via STOP RUN. clause. To exit from the program, it has no return statement, but it has an EXIT statement, to end the program.

