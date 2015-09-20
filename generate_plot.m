%%this script to generate a file of history of loading path for vpsc running. 
%%The plot of the history path is also included
step=26;
y1=@(x)0.3*(1-exp(-x/2))
y21=@(x)(1-exp(-x/2))
y22=@(x)(1-exp(-x/2))

y33=@(x)x/step
% y33=@(x)(1-exp(-x))
% plot([0:1:20],y([0:1:20]))

y_13=@(x)-0.018775*x-0.00033164;
[y_13(0.15), y_33(0.25)]

y_23=@(x)x/-16.945+0.0086482/-16.945;
% y_23=@(x)x*(-16.945)+0.0086482;
[y_23(0.15)/0.15, y_23(0.25)/0.25]

y_33=@(x)0.96594-0.00057988/x;
[y_33(0.15)/0.15, y_33(0.25)/0.25]



% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'PST00';'PSTm0';'PSTm1';'TDT00'];
load_type=['RDT00';'RDTm1';'PSRm1';'PSRm0';'PSR00';'BB000';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDTm1';'TDT00'];

    figure
    plot(y33(0:17),'r-')
    hold on
    grid on
    
for load_ind=[3,7,10]%[2,3,7,10,11]
    if load_ind==2 % based on r value varying from 0.6 to 0.65, Mark paper
        L11=1.0+0.0*y21(0:step);
        L22=-0.375-0.019*y21(0:step);
        L33=-0.625+0.019*y21(0:step);
        
    elseif load_ind==3
        
% %         good for PS11
% %         L11=1.0*ones(1,18)+0.2*y21(0:17);
% %         L22=-0.19+0.12*y21(0:17);
        L11=1.0+0.1*y21(0:step);
        L22=-0.19+0.16*y21(0:step);
        L33=-(L11+L22);
    elseif load_ind==10
        %good for PS22
%         L11=-0.2+0.17*y22(0:step);
%         L22=1.05+0.2*y21(0:step);
        L11=-0.2+0.17*y22(0:step);
        L22=1.05+0.15*y21(0:step);
        L33=-(L11+L22);
    elseif load_ind==7
        L11=(1.0+0.0*y33(0:step));
        L22=(1.0-0.1*y33(0:step));
        L33=-(L11+L22);
    elseif load_ind==11 % based on r value varying from 1 to 0.9, Mark paper
        L22=1.0+0.0*y21(0:step);
        L11=-0.5+0.026*y21(0:step);
        L33=-0.5-0.026*y21(0:step);
    end
    
%     plot(L11,L22)

% %     axis([0.5 1.5 0.5 1.5])
    
    fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/Loading/LIJ_HIST.DAT'],'r'); % reading the template of Loading condition
        for l=1:step+2
            if l<23
             line_load{load_ind}{l}=fgetl(fid_load);
            elseif l<102
                line_load{load_ind}{l}=line_load{load_ind}{22};
                line_load{load_ind}{l}(2:3)=num2str(l-2,'%d');
            else
                line_load{load_ind}{l}=line_load{load_ind}{22};
                line_load{load_ind}{l}(1:3)=num2str(l-2,'%d');
            end
            
            if l>2
                line_load{load_ind}{l}(7:17)=num2str(L11(l-2),'%+10.4E');
                line_load{load_ind}{l}(56:66)=num2str(L22(l-2),'%+10.4E');
                line_load{load_ind}{l}(103:113)=num2str(L33(l-2),'%+10.4E');
    
             end
        end
     fclose(fid_load);
     
      line_load{load_ind}{1}=[num2str(step),'   7   0.01    298.         nsteps  ictrl  eqincr  temp'];
            
    fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/Loading/LIJ_',load_type(load_ind,:),'.DAT'],'w+');
%         fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_evolvingbinary/LIJ_',load_type(load_ind,:),'.DAT'],'w+');
        for i=1:step+2
        fprintf(fid_load,'%s \n',line_load{load_ind}{1,i});
        end
        fclose(fid_load);
 end

    
s=1;
col=ones(5,1);
col(1)=1.001;
col(5)=1;

cop=ones(5,1);
cop(1)=5.01;
cop(5)=1;

h=ones(5,1);
h(1)=1.1;
h(3)=5;
h(5)=1;

lc=ones(5,1);
lc(1)=1.0;
lc(5)=1;

gl=ones(5,1);
gl(1)=5.01;
gl(2)=5;
gl(5)=1;

run=1;
run_total=1;
bs1=1; % differentiate interactions of a system with other two systems those have opposite directions
bs2=1;%0.8; % for opposite slip directions

latent{run}(1,1:24)=[s cop(run) cop(run)   h(run) gl(run) lc(run)    col(run) lc(run) lc(run)   h(run) lc(run) gl(run) ...
                     s cop(run) cop(run)   h(run) gl(run) lc(run)    col(run) lc(run) lc(run)   h(run) lc(run) gl(run)];

latent{run}(2,1:24)=[cop(run) s cop(run)   lc(run) col(run) lc(run)   gl(run) h(run) lc(run)    lc(run) h(run) gl(run) ...
                     cop(run) s cop(run)   lc(run) col(run) lc(run)   gl(run) h(run) lc(run)    lc(run) h(run) gl(run)];
            
latent{run}(3,1:24)=[cop(run) cop(run) s   lc(run) gl(run) h(run)    gl(run) lc(run) h(run)    lc(run) lc(run) col(run) ...
                     cop(run) cop(run) s   lc(run) gl(run) h(run)    gl(run) lc(run) h(run)    lc(run) lc(run) col(run)];

latent{run}(4,1:24)=[h(run) gl(run) lc(run)    s cop(run) cop(run)   h(run) lc(run) gl(run)    col(run) lc(run) lc(run) ...
                     h(run) gl(run) lc(run)    s cop(run) cop(run)   h(run) lc(run) gl(run)    col(run) lc(run) lc(run)];
            
latent{run}(5,1:24)=[lc(run) col(run) lc(run)   cop(run) s cop(run)   lc(run) h(run) gl(run)    gl(run) h(run) lc(run) ...
                     lc(run) col(run) lc(run)   cop(run) s cop(run)   lc(run) h(run) gl(run)    gl(run) h(run) lc(run)];
            
latent{run}(6,1:24)=[lc(run) gl(run) h(run)    cop(run) cop(run) s   lc(run) lc(run) col(run)   gl(run) lc(run) h(run) ...
                     lc(run) gl(run) h(run)    cop(run) cop(run) s   lc(run) lc(run) col(run)   gl(run) lc(run) h(run)];
            
latent{run}(7,1:24)=[col(run) lc(run) lc(run)   h(run) lc(run) gl(run)   s cop(run) cop(run)    h(run) gl(run) lc(run) ...
                     col(run) lc(run) lc(run)   h(run) lc(run) gl(run)   s cop(run) cop(run)    h(run) gl(run) lc(run)];
            
latent{run}(8,1:24)=[gl(run) h(run)  lc(run)   lc(run) h(run) gl(run)   cop(run) s cop(run)    lc(run) col(run) lc(run) ...
                     gl(run) h(run)  lc(run)   lc(run) h(run) gl(run)   cop(run) s cop(run)    lc(run) col(run) lc(run)];
            
latent{run}(9,1:24)=[gl(run) lc(run) h(run)    lc(run) lc(run) col(run)   cop(run) cop(run) s    lc(run) gl(run) h(run) ...
                     gl(run) lc(run) h(run)    lc(run) lc(run) col(run)   cop(run) cop(run) s    lc(run) gl(run) h(run)];
            
latent{run}(10,1:24)=[h(run) lc(run) gl(run)   col(run) lc(run) lc(run)   h(run) gl(run) lc(run)  s cop(run) cop(run) ...
                      h(run) lc(run) gl(run)   col(run) lc(run) lc(run)   h(run) gl(run) lc(run)  s cop(run) cop(run)];
            
latent{run}(11,1:24)=[lc(run) h(run) gl(run)   gl(run) h(run) lc(run)   lc(run) col(run) lc(run)  cop(run) s cop(run) ...
                      lc(run) h(run) gl(run)   gl(run) h(run) lc(run)   lc(run) col(run) lc(run)  cop(run) s cop(run)];
             
latent{run}(12,1:24)=[lc(run) lc(run) col(run)   gl(run) lc(run) h(run)   lc(run) gl(run) h(run)  cop(run) cop(run) s ...
                      lc(run) lc(run) col(run)   gl(run) lc(run) h(run)   lc(run) gl(run) h(run)  cop(run) cop(run) s];

for i=1:12
    latent{run}(i+12,1:24)=latent{run}(i,1:24);
    latent{run}(i+12,1:12)=bs1*latent{run}(i,1:12);
    latent{run}(i,13:24)=bs1*latent{run}(i,13:24);
    
end

for i=1:24
    for j=1:24
        if abs(i-j)==12 
            latent{run}(i,j)=bs2*latent{run}(i,j);
        end
    end
end

% iso(run,1:6)=[148      95.25           160           2.5      0  0];
% iso(run,1:6)=[37  18  80   10      0  0];
iso(run,1:7)=[35 1 4 1 0 0 0.1]; %good for binary-multi junction with self=1
iso_header='       tau0x,tau1x,thet0,thet1, hpfac, gndfac,HARD3DFRAC; hlatex next line';

fid_latent=fopen('/home/minhsonpham/Documents/VPSC code/VPSC7b_multijunctions/New/Fcclatent.sx','r'); % reading the template of latent hardening
    for l=1:68
    line_crys{l}=fgetl(fid_latent);
    end
fclose(fid_latent);

line_crys{1,20}=[num2str(iso(run,1:6),'%6d'),'   ', num2str(iso(run,7),'%8.4f') iso_header];
    
for i=1:24
    line_crys{1,20+i}=num2str(latent{run}(i,1:24),'%10.4f');
end

fid_latent=fopen('Fcclatent.sx','w+');
for i=1:68
    fprintf(fid_latent,'%s\n',line_crys{1,i});
end
fclose(fid_latent);

%plotting str_str.out
fid=fopen('STR_STR.OUT'); % loaded file should locate at the working directory. 
        STRSTR{run_total,1}= textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',...
            'Delimiter','whitespace','MultipleDelimsAsOne',1,'HeaderLines',1);
        Evm{run_total,1}=STRSTR{run_total,1}{1,1};
        Svm{run_total,1}=STRSTR{run_total,1}{1,2};

        E11{run_total,1}=STRSTR{run_total,1}{1,3};
        S11{run_total,1}=STRSTR{run_total,1}{1,9}-STRSTR{run_total,1}{1,11};

        E22{run_total,1}=STRSTR{run_total,1}{1,4};
        S22{run_total,1}=STRSTR{run_total,1}{1,10}-STRSTR{run_total,1}{1,11};
fclose(fid);
% subplot(1,2,1)
% plot(E11{run_total,1}*100,S11{run_total,1},'b-','linewidth',3);
% subplot(1,2,2)
% plot(E11{run_total,1}*100,S22{run_total,1},'r-','linewidth',3);

figure
plot(S11{run_total,1}(1:16),S22{run_total,1}(1:16),'b-','LineWidth',2);
axis([0 450 0 450])

y=@(x)((1-5)*exp(-x)+5).*(exp(-3*x)+1)
