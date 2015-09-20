%%%note s: self, cop: coplanar, gl: glissile, h: hirth, lc: lomer-cottrell.
%%%This assignment of latent hardening works for fcc materials and when
%%%slip system 1 interacts with the rest of potential systems (2-24)

fid_latent=fopen('./Fcclatent_template.sx','r'); % reading the template of latent hardening
    for l=1:126
    line_crys{l}=fgetl(fid_latent);
    end
fclose(fid_latent);

s=1; col=6.001; cop=1.0001; h=1.2; lc=4.1; gl=1.01;


latent(1,1:25)=[s s cop cop   h gl lc    col lc lc   h lc gl ...
                     s cop cop   h gl lc    col lc lc   h lc gl];

latent(2,1:25)=[s cop s cop   lc col lc   gl h lc    lc h gl ...
                     cop s cop   lc col lc   gl h lc    lc h gl];
            
latent(3,1:25)=[s cop cop s   lc gl h    gl lc h    lc lc col ...
                     cop cop s   lc gl h    gl lc h    lc lc col];

latent(4,1:25)=[s h gl lc    s cop cop   h lc gl    col lc lc ...
                     h gl lc    s cop cop   h lc gl    col lc lc];
            
latent(5,1:25)=[s lc col lc   cop s cop   lc h gl    gl h lc ...
                     lc col lc   cop s cop   lc h gl    gl h lc];
            
latent(6,1:25)=[s lc gl h    cop cop s   lc lc col   gl lc h ...
                     lc gl h    cop cop s   lc lc col   gl lc h];
            
latent(7,1:25)=[s col lc lc   h lc gl   s cop cop    h gl lc ...
                     col lc lc   h lc gl   s cop cop    h gl lc];
            
latent(8,1:25)=[s gl h  lc   lc h gl   cop s cop    lc col lc ...
                     gl h  lc   lc h gl   cop s cop    lc col lc];
            
latent(9,1:25)=[s gl lc h    lc lc col   cop cop s    lc gl h ...
                     gl lc h    lc lc col   cop cop s    lc gl h];
            
latent(10,1:25)=[s h lc gl   col lc lc   h gl lc  s cop cop ...
                      h lc gl   col lc lc   h gl lc  s cop cop];
            
latent(11,1:25)=[s lc h gl   gl h lc   lc col lc  cop s cop ...
                      lc h gl   gl h lc   lc col lc  cop s cop];
             
latent(12,1:25)=[s lc lc col   gl lc h   lc gl h  cop cop s ...
                      lc lc col   gl lc h   lc gl h  cop cop s];

for i=1:12
    latent(i+12,1:25)=latent(i,1:25);
end

iso(1:6)=[32.00 32.00 3.00 7.50 1.00 0.0]; 
iso_header='       tau0xf,tau0xb,tau1x,thet0,thet1; hself,hlatex next line';

%%Creating latent file
fid_latent=fopen('Fcclatent.sx','w+');
j=1;
k=0;
for i=1:24
    line_crys{1,9+k}=[num2str(iso(1:6)) iso_header];
    k=k+5;
    
    line_crys{1,9+j}=num2str(latent(i,1:25));
    j=j+5;
end

for i=1:126
    fprintf(fid_latent,'%s \n',line_crys{1,i});
end
fclose(fid_latent);

