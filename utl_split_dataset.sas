SAS forum: I want to create the separate datasets for each location,
           when number of locations are not specified

    WORKING CODE
    ============

      MAINLINAE
       do dsn='mumbai', 'bang', 'hyd';
          call symputx('dsn',dsn);

      DOSUBL
          data &dsn;
             set have(where=(loc=symget("dsn")));

see
https://goo.gl/9Gtgju
https://communities.sas.com/t5/Base-SAS-Programming/I-want-to-create-
the-separate-datasets-for-each-location-when/m-p/394422


HAVE
====

Up to 40 obs WORK.HAVE total obs=6

Obs    LOC       EMP_ID    NAME

 1     bang         1      srinivas
 2     bang         2      sudhakar
 3     hyd          3      qqqq
 4     hyd          4      hhhh
 5     mumbai       5      bhanu
 6     mumbai       6      jjjjj


WANT Three datasets MUMBAI, BANG and HYD
========================================

  WORK.MUMBAI total obs=2

  Obs     LOC      EMP_ID    NAME

   1     mumbai       5      bhanu
   2     mumbai       6      jjjjj

  WORK.BANG total obs=2

  Obs    LOC     EMP_ID      NAME

   1     bang       1      srinivas
   2     bang       2      sudhakar

  WORK.HYD total obs=2

  bs    LOC    EMP_ID    NAME

  1     hyd       3      qqqq
  2     hyd       4      hhhh

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
retain loc;
input emp_id  name$ loc$;
cards4;
1 srinivas bang
2 sudhakar bang
3 qqqq hyd
4 hhhh hyd
5 bhanu mumbai
6 jjjjj mumbai
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;
data _null_;

  do dsn='mumbai', 'bang', 'hyd';
     call symputx('dsn',dsn);
     rc=dosubl('
       data &dsn;
          set have(where=(loc=symget("dsn")));
       run;quit;
     ');
   end;

run;quit;


NOTE: There were 2 observations read from the data set WORK.HAVE.
      WHERE loc=SYMGET('dsn');
NOTE: The data set WORK.MUMBAI has 2 observations and 3 variables.
NOTE: DATA statement used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds


NOTE: There were 2 observations read from the data set WORK.HAVE.
      WHERE loc=SYMGET('dsn');
NOTE: The data set WORK.BANG has 2 observations and 3 variables.
NOTE: DATA statement used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds


NOTE: There were 2 observations read from the data set WORK.HAVE.
      WHERE loc=SYMGET('dsn');
NOTE: The data set WORK.HYD has 2 observations and 3 variables.
NOTE: DATA statement used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds


