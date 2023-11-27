:- dynamic pemilik/1


kode(na1, 'NA1').
kode(na2, 'NA2').
kode(na3, 'NA3').
kode(na4, 'NA4').
benua(na1, 'Amerika Utara').
benua(na2, 'Amerika Utara').
benua(na3, 'Amerika Utara').
benua(na4, 'Amerika Utara').

kode(sa1, 'SA1').
kode(sa2, 'SA2').
benua(sa1, 'Amerika Selatan').
benua(sa2, 'Amerika Selatan').

kode(af1, 'AF1').
kode(af2, 'AF2').
kode(af3, 'AF3').
benua(af1, 'Afrika').
benua(af2, 'Afrika').
benua(af3, 'Afrika').

kode(au1, 'AU1').
kode(au2, 'AU2').
benua(au1, 'Australia').
benua(au2, 'Australia').

kode(a1, 'A1').
kode(a2, 'A2').
kode(a3, 'A3').
kode(a4, 'A4').
kode(a5, 'A5').
kode(a6, 'A6').
kode(a7, 'A7').
benua(a1, 'Asia').
benua(a2, 'Asia').
benua(a3, 'Asia').
benua(a4, 'Asia').
benua(a5, 'Asia').
benua(a6, 'Asia').
benua(a7, 'Asia').

kode(e1, 'E1').
kode(e2, 'E2').
kode(e3, 'E3').
kode(e4, 'E4').
kode(e5, 'E5').
benua(e1, 'Eropa').
benua(e2, 'Eropa').
benua(e3, 'Eropa').
benua(e4, 'Eropa').
benua(e5, 'Eropa').

nama(na1, 'Greenland').
nama(na1, 'Kanada').
nama(na1, 'Mexico').
nama(na1, 'Amerika Serikat').


writeTetangga(Kode):
    benua(Kode, B),
    benua(KodeLain, B),
    nama(KodeLain, N),
    write(N).

main:-
    kode(na1, X),
    write(X).