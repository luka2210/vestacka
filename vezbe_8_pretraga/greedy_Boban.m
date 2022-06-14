quarter = 0.25;
dime = 0.1;
nickel = 0.05;
penny = 0.01;

trazeni_broj = 0.63;

j = 0;
while(trazeni_broj > quarter)
    trazeni_broj = trazeni_broj - quarter;
    j = j + 1;
end
trazeni_broj = 0.63;
brQuarterNovcica = j;
brQuarter = j * quarter;

noviBroj = trazeni_broj - brQuarter;

j=0;
while(noviBroj > dime)
    noviBroj = noviBroj - dime;
    j = j + 1;
end
noviBroj = trazeni_broj - brQuarter;
brDimeNovcica = j;
brDime = j * dime;

noviBroj1 = noviBroj - brDime;

j=0;
while(noviBroj1 > nickel)
    noviBroj1 = noviBroj1 - nickel;
    j = j + 1;
end
noviBroj1 = trazeni_broj - brQuarter - brDime;
brNickelNovcica = j;
brNickel = j * nickel;

noviBroj2 = noviBroj1 - brNickel;

j=0;
b=0;
while(b ~= noviBroj2)
    b = b + penny;
    j = j + 1;
end
brPennyNovcica = j;








