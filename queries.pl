:- [database].
qName(Name) :- tName(_,Name).
qNameAndCollege(Name,College) :- tCollege(C,College),
    tName(C,Name).
qNameAndCollege(Name, College) :- tName(C,Name),
    not(tCollege(C,College)),
    College=none.
qNameAndCollege(Name,College) :- tCollege(C,College),
    not(tName(C,Name)),
    Name=none.
qNameAndCollege(Crsid,Name,College) :-  tCollege(Crsid,College),
    tName(Crsid,Name),!.
qNameAndCollege(Crsid,Name,College) :- tName(Crsid,Name),
    College=none,
    not(tCollege(Crsid,College)),!.
qNameAndCollege(Crsid,Name,College) :- tCollege(Crsid,College),
    Name=none,
    not(tName(Crsid,Name)),!.
list_min([L|Ls],Min) :- list_min(Ls, L, Min).
list_min([],Min,Min).
list_min([L|Ls],Min0,Min):- Min1 is min(L,Min0),
    list_min(Ls, Min1, Min).
qBestGrade(Crsid,Grade) :- findall(Crsid,tGrade(Crsid,_,1),T),
    sort(T,L),!,
    member(Crsid,L),
    findall(Grade,tGrade(Crsid,_,Grade),NumFirsts),
    list_min(NumFirsts,Grade).
qTabulateFirsts(Crsid,Freq) :- qBestGrade(Crsid,1),
    aggregate_all(count, tGrade(Crsid,_,1),Freq).

