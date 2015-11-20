%%this matlab script is to run VPSC_multijunction
%%this script is similar to BC_multijunction.m, except it is dedicated to simulation runs stored in VPSC7b_multijunctions/New
fid_latent=fopen('/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/Fcclatent.sx','r'); % reading the template of latent hardening
    for l=1:68
    line_crys{l}=fgetl(fid_latent);
    end
fclose(fid_latent);

fid_in=fopen('/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/vpsc7.in','r'); % reading the template of VPSC input file 
    for l=1:40
    line_in{l}=fgetl(fid_in);
    end
fclose(fid_in);

%%finishing reading format

%------------reading experimental values of stress--------------------%
load('/home/minhsonpham/Documents/CMU-NIST/AA5754/Exp. data/U_PS_BB/fitted_U_PS_BB.mat')
figure_stress=open('/home/minhsonpham/Documents/CMU-NIST/AA5754/Figures/Yield surface/Flow stress_exp.fig');
%------------STRSTR-END-------------------%

s=1;
col=ones(5,1);
col(1)=2.001;
col(5)=1;

cop=ones(5,1);
cop(1)=1.0001;
cop(5)=1;

h=ones(5,1);
h(1)=1.00;
h(3)=5;
h(5)=1;

lc=ones(5,1);
lc(1)=1.2;
lc(5)=1;

gl=ones(5,1);
gl(1)=1.01;
gl(2)=5;
gl(5)=1;

run=1;
run_total=1;
bs1=0.8; % differentiate interactions of a system with other two systems those have opposite directions
bs2=0.5; % for opposite slip directions

texture=['Textuin.txt'];

% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDT00'];
load_type=['RDT00';'RDTm1';'PSRm1';'PSRm0';'PSR00';'BB000';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDTm1';'TDT00'];


  for load_ind=1:length(load_type)
      if all([2,3,7,10,11]~=load_ind)
        fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/Loading/',load_type(load_ind,:),'.3'],'r'); % reading the template of Loading condition
        for l=1:17
        line_load{load_ind}{l}=fgetl(fid_load);
        end
        fclose(fid_load);
      end
  end
  
  BC_name='BC_New_22-Oct-2015'; % the same loading paths as BC_name='BC_New_29 & 31-Oct-2014', but different latent hardening, in particular theta0
%   BC_name='BC_New_31-Oct-2014'; % the same as BC_name='BC_New_29-Oct-2014' but re-running for 3,7,10 for recorded strain paths
%   BC_name='BC_New_29-Oct-2014'; % including near uniaxial loadings based on the measured r-values
%    BC_name='BC_New_09-Oct-2014/2'; % the same as BC_New_09-Oct-2014, different paths for near exact
%   BC_name='BC_New_09-Oct-2014'; % use PSRD00 prerun as input.
%   BC_name='BC_New_08-Oct-2014';
%   BC_name='BC_New_07-Oct-2014';
% BC_name='BC_Multi_sum_Oct04';
% BC_name='BC_New_23-Apr-2014';
% BC_name='BC_New_13-Apr-2014';
% BC_name='BC_New_12-Apr-2014';
% BC_name='BC_New_11-Apr-2014';
% BC_name='BC_New_09-Apr-2014';
% BC_name='BC_New_07-Apr-2014';
% BC_name=['BC_New_',date];
% mkdir('/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name)
% cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name])


    line_in{9}=texture;
%     
%%
    
% if tex==1
%     run1=2;
%     run_total=5;
% else
%     run1=1;
    run_total=0;
%     mkdir(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',texture(1:7)])
%     cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',texture(1:7)]);
% end

for run=1%1:4  % running for different choice of latent hardening
    mkdir(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',num2str(run)])
    cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',num2str(run)])
        
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
% iso(run,1:7)=[35 1 4 1 0 0 0.1]; %good for binary-multi junction with self=1
% iso(run,1:7)=[35 13 15 1 0 0 0.003]; % BC_New_07-Oct-2014 and BC_New_08-Oct-2014 to repeat the same condition as BC_New_13-April-2014
% iso(run,1:7)=[35 4.0 7.5 1 0 0 0.003]; % BC_New_08-Oct-2014 to repeat the same condition as BC_New_13-April-2014
% iso(run,1:7)=[32.00 3.00 7.50 1.00 0.00 0.00   0.0030]; % BC_New_09-Oct-2014 use PSRD prerun as the initial input
iso(run,1:7)=[32.0 3.0  20.5 5.00 0.00 0.00   0.003]; % BC_New_09-Oct-2014 use PSRD prerun as the initial input
iso_header='       tau0x,tau1x,thet0,thet1, hpfac, gndfac,HARD3FRAC; hlatex next line';

for load_ind=1:length(load_type)%[3,7,10]%1:length(load_type) %for different loading condition
    run_total=load_ind;%run_total+1;
    
    mkdir(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
        num2str(run),'/',load_type(load_ind,:)])
    cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
        num2str(run),'/',load_type(load_ind,:)])
    
%%Creating input files for running VPSC

line_crys{1,20}=[num2str(iso(run,1:6),'%6.2f'),'   ', num2str(iso(run,7),'%8.4f') iso_header];
    
for i=1:24
    line_crys{1,20+i}=num2str(latent{1}(i,1:24),'%10.4f');
end

fid_latent=fopen('Fcclatent.sx','w+');
for i=1:68
    fprintf(fid_latent,'%s\n',line_crys{1,i});
end
fclose(fid_latent);


%create vpsc main input file (vpsc7.in) in the working directory
if load_ind==3
    line_in{32}='1'; % = 2 if want to run PCYS for BB condition
else
    line_in{32}='1';
end

line_in{23}='5              nwrite (frequency of texture downloads) ';

if any([2,3,7,10,11]==load_ind)
    line_in{34}='1';
else line_in{34}='0';
end
 
line_in{35}=['Loading.3'];

fid_in=fopen('vpsc7.in','w+');
for i=1:40
    fprintf(fid_in,'%s \n',line_in{1,i});
end
fclose(fid_in);

%create the texture input file in the working directory
copyfile('/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/Textuin.txt')

copyfile('/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/PSR00_prerun/BB_2ndstep/POSTMORT.IN')

%create loading condition file in the working directory
 if   any([2,3,7,10,11]==load_ind)%load_ind==2||load_ind==6||load_ind==9 %load_ind==2||load_ind==8 %(for load_type without BBTRD)
    copyfile(['/home/minhsonpham/Documents/VPSC_code/Loading/LIJ_',load_type(load_ind,:),'.DAT']); % copying the template of Loading condition
    movefile(['LIJ_',load_type(load_ind,:),'.DAT'],'Loading.3')
 else
    if (load_ind==6)||(load_ind==7)
        step=20;
    else step=20; % to apply different deformation step if necessary
    end

    if load_ind<=7
        line_load{load_ind}{1,1}=[num2str(step) '  1   0.01    298.         nsteps  ictrl  eqincr  temp'];
    else
        line_load{load_ind}{1,1}=[num2str(step) '  2   0.01    298.         nsteps  ictrl  eqincr  temp'];

    end

    fid_load=fopen('Loading.3','w+');
    for i=1:17
        fprintf(fid_load,'%s \n',line_load{load_ind}{1,i});
    end
        fclose(fid_load);
 end

% system(['/home/minhsonpham/Documents/VPSC\ code/VPSC7b_multijunctions/VPSC7b_new_manuscript']);

% system(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/vpsc7_multi_10_08_2014']);%for BC_New_07-Oct-2014

% system(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/vpsc7_multi_10_07_2014']);%for BC_New_07-Oct-2014


%  %------------------%
%     fid=fopen('STR_STR.OUT'); % loaded file should locate at the working directory. 
%         STRSTR{run_total,1}= textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',...
%             'Delimiter','whitespace','MultipleDelimsAsOne',1,'HeaderLines',1);
%         Evm{run_total,1}=STRSTR{run_total,1}{1,1};
%         Svm{run_total,1}=STRSTR{run_total,1}{1,2};
% 
%         E11{run_total,1}=STRSTR{run_total,1}{1,3};
%         S11{run_total,1}=STRSTR{run_total,1}{1,9}-STRSTR{run_total,1}{1,11};
% 
%         E22{run_total,1}=STRSTR{run_total,1}{1,4};
%         S22{run_total,1}=STRSTR{run_total,1}{1,10}-STRSTR{run_total,1}{1,11};
% fclose(fid);
%     
% % figure
% % plot(E11{run_total,1}*100,E22{run_total,1}*100,'LineWidth',3)
% % grid on
% % hold on
% % set(gca,'FontSize',14,'fontweight','b')
% % ylabel('\epsilon_{22} (%)','FontSize',20,'fontweight','b')
% % xlabel('\epsilon_{11} (%)','FontSize',20,'fontweight','b')
% %%plot stress response
% figure_stress
% plot(S11{run_total,1},S22{run_total,1},'b-','LineWidth',2);
% 
% figure
% subplot(1,2,1)
% if load_ind==1
%     plot([0:19],URD_11,'k-*','linewidth',3);
% elseif (load_ind>1)&&(load_ind<5)
%     plot([0:19],PSRD_11,'k-*','linewidth',3);
% elseif load_ind==5||load_ind==6
%     plot([0:19],BB_S11,'k-*','linewidth',3);
% elseif (load_ind>6)&&(load_ind<10)
%     plot([0:19],PSTD_11,'k-*','linewidth',3);
% 
% end
%     hold on
%     grid on
%     
% if (load_ind<7)
%     plot(E11{run_total,1}*100,S11{run_total,1},'r-','linewidth',3);
% elseif (load_ind<10)
%     plot(E22{run_total,1}*100,S11{run_total,1},'r-','linewidth',3);
% end
% 
% legend('Exp','Modelling')
% set(gca,'FontSize',14,'fontweight','b')
% ylabel('\sigma_{11} (MPa)','FontSize',20,'fontweight','b')
% xlabel('\epsilon_{11} (%)','FontSize',20,'fontweight','b')
% 
% subplot(1,2,2)
% if (load_ind>1)&&(load_ind<5)
%     plot([0:19],PSRD_22,'k-*','linewidth',3);
%     hold on
%     grid on
%     plot(E11{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
% elseif load_ind==5||load_ind==6
%     plot([0:19],BB_S22,'k-*','linewidth',3);
%     hold on
%     grid on
%     plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
% elseif (load_ind>6)&&(load_ind<10)
%     plot([0:19],PSTD_22,'k-*','linewidth',3);
%     hold on
%     grid on
%     plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
% elseif load_ind==10
%     plot([0:19],UTD_22,'k-*','linewidth',3);
%     hold on
%     grid on
%     plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
% end
% legend('Exp','Modelling')
% set(gca,'FontSize',14,'fontweight','b')
% ylabel('\sigma_{22} (MPa)','FontSize',20,'fontweight','b')
% xlabel('\epsilon_{22} (%)','FontSize',20,'fontweight','b')
% 
% saveas(gcf,['Stress_',load_type(load_ind,:),'.fig'])
% saveas(gcf,['Stress_',load_type(load_ind,:),'.tiff'])
% %close(gcf)
% 
end % for different choice of loading conditions
end % for latent running

y=@(x)x
plot([0:50:450],y([0:50:450]))

y=@(x)exp(-x)
plot([0:0.01:0.3],y([0:0.01:0.3]))


filename=[BC_name,'.mat'];
save (['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',filename])
% clearvars -except BC_name load_type line_crys line_in line_load...
%     s col cop h lc step texture BB_S11 BB_S22 PSRD_11 PSRD_22 PSTD_11 PSTD_22...
%     URD_11 URD_22 UTD_11 UTD_22

%% **********************For post analysis********************
% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'PST00';'PSTm0';'PSTm1';'TDT00'];
% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDT00'];
load_type=['RDT00';'RDTm1';'PSRm1';'PSRm0';'PSR00';'BB000';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDTm1';'TDT00'];

BC_name='BC_New_22-Oct-2015'; % the same loading paths as BC_name='BC_New_29 & 31-Oct-2014', but different latent hardening, in particular theta0
% BC_name='BC_New_31-Oct-2014'; % the same as BC_name='BC_New_29-Oct-2014' but re-running for 3,7,10 for recorded strain paths
% BC_name='BC_New_29-Oct-2014'; % including near uniaxial loadings based on the measured r-values
% BC_name='BC_New_08-Oct-2014'; % evolution of stress paths is good, but too much over estimate
% BC_name='BC_New_23-Apr-2014';
% BC_name='BC_New_13-Apr-2014'; %BB good, Near plane conditions fit the experimental data well.
% BC_name='BC_New_12-Apr-2014'; %running for all load_type. BB quite good, near plane strain makes PS-11 good, PS-22 shape good
% BC_name='BC_New_11-Apr-2014'; %running for all load_type. BB good, others bad
% BC_name='BC_New_09-Apr-2014'; % run for all load_type. BB good, others bad
% BC_name='BC_New_07-Apr-2014'; %Only run for BB. not good results
% BC_name='BC_New_April042014'; %Exact straining
% BC_name='BC_Multi_sum_Oct04'; %2013
cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name])


%**************Texture extraction********************
run=1;
for load_ind=1:length(load_type)%[3,7,10] %[3,7,10] for 'BC_New_31-Oct-2014' %1:length(load_type) %for different loading condition
run_total=load_ind;
cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
num2str(run),'/',load_type(load_ind,:)])
if line_in{23}(1)=='5'
    fid=fopen('TEX_PH1.OUT'); % loaded file should locate at the working directory.
    for i=1:99768
        TEX_ALL{run_total}{i}= fgetl(fid);
    end
fclose(fid);


fid_tex_post1=fopen('TEX_PH1_5.OUT','w+');
fid_tex_post2=fopen('TEX_PH1_10.OUT','w+');
fid_tex_post3=fopen('TEX_PH1_15.OUT','w+');
fid_tex_post4=fopen('TEX_PH1_20.OUT','w+');
for i=1:24942
    fprintf(fid_tex_post1,'%s \n',TEX_ALL{run_total}{i});
    fprintf(fid_tex_post2,'%s \n',TEX_ALL{run_total}{i+24942});
    fprintf(fid_tex_post3,'%s \n',TEX_ALL{run_total}{i+2*24942});
    fprintf(fid_tex_post4,'%s \n',TEX_ALL{run_total}{i+3*24942});
end
fclose(fid_tex_post1);
fclose(fid_tex_post2);
fclose(fid_tex_post3);
fclose(fid_tex_post4);
end % end of splitting texture
end

%% 09232015: this section to convert TEXTURE.OUT to TEXTURE.COD and smooth COD file
for run=1
for load_ind=1:length(load_type)%[3,7,10]%[3,7,10] for 'BC_New_31-Oct-2014' %1:length(load_type) %for different loading condition
    load_ind    
    cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
        num2str(run),'/',load_type(load_ind,:)])
system(['/home/minhsonpham/Documents/MATLAB/Matlab\ for\ VPSC_Multijunction/VPSC_Multijunction_Matlabscript/wts2cod_con.sh']);
end % for different choice of loading conditions
end
%%

%% **************Stress&strain analysis****************
figure_stress=open('/home/minhsonpham/Documents/CMU-NIST/AA5754/Figures/Yield surface/Flow stress_exp.fig');
run_total=0;
run=1;
for load_ind=1:length(load_type)%[3,7,10]%1:length(load_type) %for different loading condition
run_total=load_ind;
cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
num2str(run),'/',load_type(load_ind,:)])
%------------------%
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
plot(S11{run_total,1},S22{run_total,1},'r-','LineWidth',2);
end
% saveas (gcf,['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',BC_name,'.fig'])


figure_stress=open('/home/minhsonpham/Documents/CMU-NIST/AA5754/Figures/Yield surface/Flow stress_exp.fig');
for run_total=[2,11]%1:length(load_type)%[3,7]%[1,4,5,6]%
    if any([1,5,6,8,12]==run_total)
        plot(S11{run_total,1},S22{run_total,1},'b-','LineWidth',3);
    elseif run_total==2
        plot(S11{run_total,1}-S22{run_total,1},S22{run_total,1}-S22{run_total,1},'g--','LineWidth',3);
    elseif run_total==11
        plot(S11{run_total,1}-S11{run_total,1},S22{run_total,1}+S11{run_total,1},'g--','LineWidth',3);
    else
        plot(S11{run_total,1},S22{run_total,1},'r-','LineWidth',3);
    end
end

figure % to plot r values (solid), q values (dashed)
for run_total=[3,7,10]%1:length(load_type)
%    if run_total==2
        plot(STRSTR{run_total,1}{1,4}./STRSTR{run_total,1}{1,5},'r-','LineWidth',3);
        hold on
        plot(abs(STRSTR{run_total,1}{1,4}./STRSTR{run_total,1}{1,3}),'r--','LineWidth',3);
%    elseif run_total==11
        plot(STRSTR{run_total,1}{1,3}./STRSTR{run_total,1}{1,5},'b-','LineWidth',3);
        plot(abs(STRSTR{run_total,1}{1,3}./STRSTR{run_total,1}{1,4}),'b--','LineWidth',3);
%    end
end

figure % to plot strain paths
for run_total=[3,7,10]%1:length(load_type)
    if any([1,5,6,8,12]==run_total) 
        plot(STRSTR{run_total,1}{1,3},STRSTR{run_total,1}{1,4},'b-','LineWidth',3);
        hold on
    elseif run_total<7
        plot(STRSTR{run_total,1}{1,3},STRSTR{run_total,1}{1,4},'r-','LineWidth',3);
        hold on
    elseif run_total==7
        plot(STRSTR{run_total,1}{1,3},STRSTR{run_total,1}{1,4},'k-','LineWidth',3);
    else
        plot(STRSTR{run_total,1}{1,3},STRSTR{run_total,1}{1,4},'r--','LineWidth',3);
    end
end

plot([0:0.01:0.2],[0:0.01:0.2],'-','color',[0.5 0.5 0.5])


%% **********************For detailed stress-strain curves***********
run_total=0;
for load_ind=6%1:length(load_type) %for different loading condition
run_total=run_total+1;
cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
num2str(run),'/',load_type(load_ind,:)])
%------------------%
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
figure
subplot(1,2,1)
if load_ind==1
    plot([0:19],URD_11,'k-*','linewidth',3);
elseif (load_ind>1)&&(load_ind<6)
    plot([0:19],PSRD_11,'k-*','linewidth',3);
elseif load_ind==6||load_ind==7
    plot([0:19],BB_S11,'k-*','linewidth',3);
elseif (load_ind>7)&&(load_ind<12)
    plot([0:19],PSTD_11,'k-*','linewidth',3);

end
    hold on
    grid on
    
if (load_ind<8)
    plot(E11{run_total,1}*100,S11{run_total,1},'r-','linewidth',3);
elseif (load_ind<12)
    plot(E22{run_total,1}*100,S11{run_total,1},'r-','linewidth',3);
end

legend('Exp','Modelling')
set(gca,'FontSize',14,'fontweight','b')
ylabel('\sigma_{11} (MPa)','FontSize',20,'fontweight','b')
xlabel('\epsilon_{11} (%)','FontSize',20,'fontweight','b')

subplot(1,2,2)
if (load_ind>1)&&(load_ind<6)
    plot([0:19],PSRD_22,'k-*','linewidth',3);
    hold on
    grid on
    plot(E11{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
elseif load_ind==6||load_ind==7
    plot([0:19],BB_S22,'k-*','linewidth',3);
    hold on
    grid on
    plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
elseif (load_ind>7)&&(load_ind<12)
    plot([0:19],PSTD_22,'k-*','linewidth',3);
    hold on
    grid on
    plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
else
    plot([0:19],UTD_22,'k-*','linewidth',3);
    hold on
    grid on
    plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
end
legend('Exp','Modelling')
set(gca,'FontSize',14,'fontweight','b')
ylabel('\sigma_{22} (MPa)','FontSize',20,'fontweight','b')
xlabel('\epsilon_{22} (%)','FontSize',20,'fontweight','b')
end % for different choice of loading conditions


%*************************
% load_type=['RDT';'PSR';'BBT';'PST';'TDT'];
run_total=0;
for load_ind=1:length(load_type) %for different loading condition
run_total=run_total+1;
cd(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/',BC_name,'/',...
num2str(run),'/',load_type(load_ind,:)])
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
%%plot stress response
figure_stress
plot(S11{run_total,1},S22{run_total,1},'r-','LineWidth',4);
figure
subplot(1,2,1)
if load_ind==1
plot([0:19],URD_11,'k-*','linewidth',3);
elseif load_ind==2
plot([0:19],PSRD_11,'k-*','linewidth',3);
elseif load_ind==3
plot([0:19],BB_S11,'k-*','linewidth',3);
elseif load_ind==4
plot([0:19],PSTD_11,'k-*','linewidth',3);
hold on
grid on
plot(E22{run_total,1}*100,S11{run_total,1},'r-','linewidth',3);
end
hold on
grid on
if load_ind<4
plot(E11{run_total,1}*100,S11{run_total,1},'r-','linewidth',3);
end
legend('Exp','Modelling')
set(gca,'FontSize',14,'fontweight','b')
ylabel('\sigma_{11} (MPa)','FontSize',20,'fontweight','b')
xlabel('\epsilon_{11} (%)','FontSize',20,'fontweight','b')
subplot(1,2,2)
if load_ind==2
plot([0:19],PSRD_22,'k-*','linewidth',3);
hold on
grid on
plot(E11{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
elseif load_ind==3
plot([0:19],BB_S22,'k-*','linewidth',3);
hold on
grid on
plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
elseif load_ind==4
plot([0:19],PSTD_22,'k-*','linewidth',3);
hold on
grid on
plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
elseif load_ind==5
plot([0:19],UTD_22,'k-*','linewidth',3);
hold on
grid on
plot(E22{run_total,1}*100,S22{run_total,1},'b-','linewidth',3);
end
legend('Exp','Modelling')
set(gca,'FontSize',14,'fontweight','b')
ylabel('\sigma_{22} (MPa)','FontSize',20,'fontweight','b')
xlabel('\epsilon_{22} (%)','FontSize',20,'fontweight','b')
end
