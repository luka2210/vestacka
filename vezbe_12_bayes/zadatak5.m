clear;

podaci = {
    '35','Srednji','Da','Dobar','Da';
    '30','Visok','Ne','Srednji','Ne';
    '43','Nizak','Da','Slabiji','Ne';
    '35','Srednji','Ne','Dobar','Da';
    '45','Nizak','Ne','Dobar','Da';
    '35','Visok','Ne','Odlican','Da';
    '35','Srednji','Ne','Slabiji','Ne';
    '25','Nizak','Ne','Slabiji','Ne';
    '28','Visok','Ne','Srednji','Da';
};

broj_redova = length(podaci(:,1));

kupuje_komp_da = 0;
kupuje_komp_ne = 0;
kupuje_komp_ukupno = broj_redova;

godina_35_da = 0;
godina_35_ne = 0;

godina_30_da = 0;
godina_30_ne = 0;

godina_43_da = 0;
godina_43_ne = 0;

godina_45_da = 0;
godina_45_ne = 0;

godina_25_da = 0;
godina_25_ne = 0;

godina_28_da = 0;
godina_28_ne = 0;

prihod_srednji_da = 0;
prihod_srednji_ne = 0;

prihod_visok_da = 0;
prihod_visok_ne = 0;

prihod_nizak_da = 0;
prihod_nizak_ne = 0;

student_da_da = 0;
student_da_ne = 0;

student_ne_da = 0;
student_ne_ne = 0;

kr_dobar_da = 0;
kr_dobar_ne = 0;

kr_srednji_da = 0;
kr_srednji_ne = 0;

kr_slabiji_da = 0;
kr_slabiji_ne = 0;

kr_odlican_da = 0;
kr_odlican_ne = 0;

for i = 1:broj_redova
    if(strcmp(podaci(i,5),'Da'))
        kupuje_komp_da = kupuje_komp_da + 1;
    end
    if(strcmp(podaci(i,5),'Ne'))
        kupuje_komp_ne = kupuje_komp_ne + 1;
    end
    
    %godine
    if(strcmp(podaci(i,1), '35') && strcmp(podaci(i,5),'Da'))
        godina_35_da = godina_35_da + 1;
    end
    if(strcmp(podaci(i,1), '35') && strcmp(podaci(i,5),'Ne'))
        godina_35_ne = godina_35_ne + 1;
    end
    
    if(strcmp(podaci(i,1), '30') && strcmp(podaci(i,5),'Da'))
        godina_30_da = godina_30_da + 1;
    end
    if(strcmp(podaci(i,1), '30') && strcmp(podaci(i,5),'Ne'))
        godina_30_ne = godina_30_ne + 1;
    end
    
    if(strcmp(podaci(i,1), '43') && strcmp(podaci(i,5),'Da'))
        godina_43_da = godina_43_da + 1;
    end
    if(strcmp(podaci(i,1), '43') && strcmp(podaci(i,5),'Ne'))
        godina_43_ne = godina_43_ne + 1;
    end
    
    if(strcmp(podaci(i,1), '45') && strcmp(podaci(i,5),'Da'))
        godina_45_da = godina_45_da + 1;
    end
    if(strcmp(podaci(i,1), '45') && strcmp(podaci(i,5),'Ne'))
        godina_45_ne = godina_45_ne + 1;
    end
    
    if(strcmp(podaci(i,1), '25') && strcmp(podaci(i,5),'Da'))
        godina_25_da = godina_25_da + 1;
    end
    if(strcmp(podaci(i,1), '25') && strcmp(podaci(i,5),'Ne'))
        godina_25_ne = godina_25_ne + 1;
    end
    
    if(strcmp(podaci(i,1), '28') && strcmp(podaci(i,5),'Da'))
        godina_28_da = godina_28_da + 1;
    end
    if(strcmp(podaci(i,1), '28') && strcmp(podaci(i,5),'Ne'))
        godina_28_ne = godina_28_ne + 1;
    end
    
  %%prihod
    if(strcmp(podaci(i,2), 'Srednji') && strcmp(podaci(i,5),'Da'))
        prihod_srednji_da = prihod_srednji_da + 1;
    end
    if(strcmp(podaci(i,2), 'Srednji') && strcmp(podaci(i,5),'Ne'))
        prihod_srednji_ne = prihod_srednji_ne + 1;
    end
    if(strcmp(podaci(i,2), 'Visok') && strcmp(podaci(i,5),'Da'))
        prihod_visok_da = prihod_visok_da + 1;
    end
    if(strcmp(podaci(i,2), 'Visok') && strcmp(podaci(i,5),'Ne'))
        prihod_visok_ne = prihod_visok_ne + 1;
    end
    if(strcmp(podaci(i,2), 'Nizak') && strcmp(podaci(i,5),'Da'))
        prihod_nizak_da = prihod_nizak_da + 1;
    end
    if(strcmp(podaci(i,2), 'Nizak') && strcmp(podaci(i,5),'Ne'))
        prihod_nizak_ne = prihod_nizak_ne + 1;
    end
  
    
    %student
    if(strcmp(podaci(i,3), 'Da') && strcmp(podaci(i,5),'Da'))
        student_da_da = student_da_da + 1;
    end
    if(strcmp(podaci(i,3), 'Da') && strcmp(podaci(i,5),'Ne'))
        student_da_ne = student_da_ne + 1;
    end
    if(strcmp(podaci(i,3), 'Ne') && strcmp(podaci(i,5),'Da'))
        student_ne_da = student_ne_da + 1;
    end
    if(strcmp(podaci(i,3), 'Ne') && strcmp(podaci(i,5),'Ne'))
        student_ne_ne = student_ne_ne + 1;
    end
    
    %kr
    
    if(strcmp(podaci(i,4), 'Dobar') && strcmp(podaci(i,5),'Da'))
        kr_dobar_da = kr_dobar_da + 1;
    end
    if(strcmp(podaci(i,4), 'Dobar') && strcmp(podaci(i,5),'Ne'))
        kr_dobar_ne = kr_dobar_ne + 1;
    end
    
    if(strcmp(podaci(i,4), 'Srednji') && strcmp(podaci(i,5),'Da'))
        kr_srednji_da = kr_srednji_da + 1;
    end
    if(strcmp(podaci(i,4), 'Srednji') && strcmp(podaci(i,5),'Ne'))
        kr_srednji_ne = kr_srednji_ne + 1;
    end
    
    if(strcmp(podaci(i,4), 'Slabiji') && strcmp(podaci(i,5),'Da'))
        kr_slabiji_da = kr_slabiji_da + 1;
    end
    if(strcmp(podaci(i,4), 'Slabiji') && strcmp(podaci(i,5),'Ne'))
        kr_slabiji_ne = kr_slabiji_ne + 1;
    end
    
    if(strcmp(podaci(i,4), 'Odlican') && strcmp(podaci(i,5),'Da'))
        kr_odlican_da = kr_odlican_da + 1;
    end
    if(strcmp(podaci(i,4), 'Odlican') && strcmp(podaci(i,5),'Ne'))
        kr_odlican_ne = kr_odlican_ne + 1;
    end
end


p_da = (godina_35_da / kupuje_komp_da)*(prihod_srednji_da / kupuje_komp_da)*(student_da_da / kupuje_komp_da)*(kr_srednji_da / kupuje_komp_da)*(kupuje_komp_da / kupuje_komp_ukupno)
p_ne = (godina_35_ne / kupuje_komp_ne)*(prihod_srednji_ne / kupuje_komp_ne)*(student_da_ne / kupuje_komp_ne)*(kr_srednji_ne / kupuje_komp_ne)*(kupuje_komp_ne / kupuje_komp_ukupno)

if p_da>p_ne
    disp('da')
else 
    disp('ne')
end