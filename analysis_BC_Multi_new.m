%% Plotting experimental ODF
exp_cod=['UNI15.COD   ';'PS15.COD    ';'BB15.COD    ';'BB20.COD    ';'PS15_TD.COD ';'UNI15_TD.COD'];
cd('D:\CMU-NIST\AA5754\COD files\Exp');
     copyfile('D:\CMU-NIST\AA5754\BC\plottex.m')

% exp_cod=['BB05.COD';'BB10.COD';'BB15.COD'];

for load_ind=1:6
    %------------------%
    if load_ind==1
        fid=fopen(['D:\CMU-NIST\AA5754\COD files\Exp\',...
        exp_cod(load_ind,1:9)]); % Reading smoothed cod file
    elseif load_ind==2
    fid=fopen(['D:\CMU-NIST\AA5754\COD files\Exp\',...
        exp_cod(load_ind,1:8)]);
    elseif load_ind==3
    fid=fopen(['D:\CMU-NIST\AA5754\COD files\Exp\',...
        exp_cod(load_ind,1:8)]);
    elseif load_ind==4
    fid=fopen(['D:\CMU-NIST\AA5754\COD files\Exp\',...
        exp_cod(load_ind,1:8)]);
    elseif load_ind==5
    fid=fopen(['D:\CMU-NIST\AA5754\COD files\Exp\',...
        exp_cod(load_ind,1:11)]); % Reading smoothed cod file 
    elseif load_ind==6
        fid=fopen(['D:\CMU-NIST\AA5754\COD files\Exp\',...
        exp_cod(load_ind,1:12)]); % Reading smoothed cod file
    end
    
    m=1;
for n=1:19
    smooth_tex{run_total,m}= textscan(fid,'%6f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f',...
            'HeaderLines',2);
    for o=1:19
       dummy_tex{m}(:,o)=smooth_tex{run_total,m}{1,o}(:);
    end
    m=m+1;
    textscan(fid,'%s',1);
end
fclose(fid);


for n=1:19
odf_exp{load_ind}(:,:,n)=dummy_tex{1,n};
end

%%plot texture
plottex(exp_cod(load_ind,1:12),odf_exp{load_ind});

end
%%------end------------

%------------reading experimental values of stress--------------------%
clear
load('D:\CMU-NIST\AA5754\Exp. data\U_PS_BB\fitted_U_PS_BB.mat')
%figure_stress=open('D:\CMU-NIST\AA5754\Figures\Yield surface\Flow stress_exp.fig');
%------------STRSTR-END-------------------%

%fitting function for stress_strain curve 
power_law=fittype('a/b*(1-exp(-b*x))+c'); 
            
options1 = fitoptions(power_law);
options1.Robust = 'LAR';
options1.MaxFunEvals = 6e3;
options1.MaxIter = 3e4;
options1.TolFun=10-10;
options1.StartPoint = [9.9  0.1     128];
options1.Upper =      [100   1       400];
options1.Lower =      [0    0        0]; 

% texture=['Textuin.txt'];
% 
% load_type=['RDT';'PSR';'BBT';'PST';'TDT'];
% 
label=['(b)';'(c)';'(d)';'(e)';'(f)';'(a)'];

s=1;
col=ones(5,1);
col(1)=6.001;
col(5)=1;

cop=ones(5,1);
cop(1)=1.0001;
cop(5)=1;

h=ones(5,1);
h(1)=5.2;
h(3)=5;
h(5)=1;

lc=ones(5,1);
lc(1)=8.1;
lc(5)=1;

gl=ones(5,1);
gl(1)=1.01;
gl(2)=5;
gl(5)=1;

run=1;
run_total=1;
bs1=1; % differentiate interactions of a system with other two systems those have opposite directions
bs2=0.8; % for opposite slip directions

texture=['Textuin.txt'];

% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'PST00';'PSTm0';'PSTm1';'TDT00'];
load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'BB005';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDT00'];

  BC_name='BC_New_31-Oct-2014'; % the same as BC_name='BC_New_29-Oct-2014' but re-running for 3,7,10 for recorded strain paths
%   BC_name='BC_New_29-Oct-2014'; % including near uniaxial loadings based on the measured r-values
% BC_name='BC_New_09-Oct-2014/2'; % the same as BC_New_09-Oct-2014, different paths for near exact
% BC_name='BC_Multi_sum_Oct04';
% BC_name='BC_Multi_Sep30';
% BC_name='BC_New_23-Apr-2014';


% path_dir='D:\CMU-NIST\VPSC7b_multijunctions\New\';
% slash_dir='\';

path_dir='~/Documents/VPSC_code/VPSC7b_multijunctions/New/';
slash_dir='/';


cd([path_dir,BC_name])


for tex=1
    run_total=0;
%     cd(['D:\CMU-NIST\Multijunction\VPSC7b\BC_Multi_5\',BC_name,slash_linux,texture(tex,1:7)]);
%     load(['D:\CMU-NIST\Multijunction\VPSC7b\BC_Multi_5\',BC_name,slash_linux,texture(tex,1:7),slash_linux,BC_name,'Textuin2.mat']);
    cd([path_dir,BC_name]);

% end

for run=1%:4  % running for different choice of latent hardening
    cd([path_dir,BC_name,slash_dir,num2str(run)])
    
for load_ind=1:length(load_type) %for different loading condition
    run_total=run_total+1;
  if load_ind<5||load_ind>6  
    cd([path_dir,BC_name,slash_dir,num2str(run),slash_dir,load_type(load_ind,:)])
  else
      cd([path_dir,'PSR00_prerun',slash_dir,'BB_2ndstep'])
  end
    
%     copyfile('D:\CMU-NIST\AA5754\BC\plottex.m')


 %------------------%
 if load_ind~=6 
     fid=fopen('STR_STR.OUT'); % loaded file should locate at the working directory. 
 else
     fid=fopen('STR_STR_PSR5%.OUT');
 end
        STRSTR{run_total,1}= textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',...
            'Delimiter','whitespace','MultipleDelimsAsOne',1,'HeaderLines',1);
        Evm{run_total,1}=STRSTR{run_total,1}{1,1};
        Svm{run_total,1}=STRSTR{run_total,1}{1,2};

        E11{run_total,1}=STRSTR{run_total,1}{1,3};
        S11{run_total,1}=STRSTR{run_total,1}{1,9}-STRSTR{run_total,1}{1,11};

        E22{run_total,1}=STRSTR{run_total,1}{1,4};
        S22{run_total,1}=STRSTR{run_total,1}{1,10}-STRSTR{run_total,1}{1,11};
fclose(fid);
 
y2=@(x)x;


% %------------------%
% if load_ind==5
%     fid=fopen('TEX_PH1_15.cmh'); % Reading smoothed cod file 
% else fid=fopen('TEX_PH1.cmh'); % Reading smoothed cod file 
% end
% 
%     m=1;
% for n=1:19
%     smooth_tex{run_total,m}= textscan(fid,'%6f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f %4f',...
%             'HeaderLines',2);
%     for o=1:19
%        dummy_tex{m}(:,o)=smooth_tex{run_total,m}{1,o}(:);
%     end
%     m=m+1;
%     textscan(fid,'%s',1);
% end
% fclose(fid);
% 
% 
% for n=1:19
% odf_out{run_total}(:,:,n)=dummy_tex{1,n};
% end
% 
% %%plot texture
% plottex(['TEX_OUT_15',load_type(load_ind,:)],odf_out{run_total});

% %%loading expertimental odf
% if load_ind==1
%      fig_tex=open('D:\CMU-NIST\AA5754\COD files\Exp\UNI15.COD   .fig')
% 
% elseif load_ind==2
%     fig_tex=open('D:\CMU-NIST\AA5754\COD files\Exp\PS15.COD    .fig')
% elseif load_ind==3
%     fig_tex=open('D:\CMU-NIST\AA5754\COD files\Exp\BB15.COD    .fig')
% elseif load_ind==4
%     fig_tex=open('D:\CMU-NIST\AA5754\COD files\Exp\PS15_TD.COD .fig')
% %close(gcf)
% elseif load_ind==5
%     fig_tex=open('D:\CMU-NIST\AA5754\COD files\Exp\UNI15_TD.COD.fig')
% end

end % for different choice of loading conditions
end % for latent running

%% Concering work done and plot yield surface in term of same work
l=1; 
k=1;
iso_work_ind=zeros(run_total,22);  
strain_range=[0:0.001:30];

for m=1:run_total 
        [fit_S11{m},gof_S11]=fit([1:length(S11{m})]',S11{m}(1:length(S11{m})),'poly4','Robust','LAR');
        [fit_S22{m},gof_S22]=fit([1:length(S11{m})]',S22{m}(1:length(S11{m})),'poly4','Robust','LAR');

        %note for BC_Multi_Sept30: run_total=8 has a different length of str_str
        work11=cumtrapz(abs(E11{m}*100),S11{m}); 
        work22=cumtrapz(abs(E22{m}*100),S22{m});
%          plot(S11{m})
%         hold on
%         grid on
%         plot(feval(fit_S11{m},[1:20]),'r--')
        
        % fit work vs strain
        if mod(m,11)>=5&&mod(m,10)<=7
            work{m}=work11+work22;
        elseif mod(m,11)<=4
            work{m}=work11;
        else  
            work{m}=work22;
        end
        
        fit_work{m}=fit([1:length(work{m})]',work{m},'power1');
        
    
    if mod(m,11)~=1 && mod(m,11)~=0   
        for n=2:length(work{m})+1
            iso_work_ind(m,n)=find(abs(feval(fit_work{m},[0:0.001:30])-feval(fit_work{1},n))<=1,1,'first');
            strain(m,n)=strain_range(iso_work_ind(m,n));
            stress11{m}(n-1)=feval(fit_S11{m},strain(m,n));
            stress22{m}(n-1)=feval(fit_S22{m},strain(m,n));
        end
    elseif mod(m,11)==1
        stress11{m}=S11{m};
        stress22{m}=zeros(1,length(S11{m}));
    elseif mod(m,11)==0
        stress22{m}=S22{m};
        stress11{m}=zeros(1,length(S22{m}));
    end
    
    if mod(m,11)==0
    for i=1:20
        S11_cau{k}(i,:)=[stress11{m-10}(i),stress11{m-9}(i),...
            stress11{m-8}(i),stress11{m-7}(i),...
            stress11{m-6}(i),...
            stress11{m-4}(i),...
            stress11{m-3}(i),...
            stress11{m-2}(i),...
            stress11{m-1}(i),...
            stress11{m}(i)];
        S22_cau{k}(i,:)=[stress22{m-9}(i),stress22{m-9}(i),...
            stress22{m-8}(i),stress22{m-7}(i),stress22{m-6}(i),...
            stress22{m-4}(i),...
            stress22{m-3}(i),...
            stress22{m-2}(i),...
            stress22{m-1}(i),...
            stress22{m}(i)];
    end
    l=l+5;
    k=k+1;
    end
end % 

%  fig_str(tex)=open('D:\Publications\Writing papers\MSP13\Figures\YS_reworked_Son_Fig 17.fig'); % for HP
 
 fig_str(tex)=open('/home/minhsonpham/Documents/CMU-NIST/AA5754/Exp. data/U_PS_BB/YS_Mark.fig'); % for Linux
 
%  set(fig_str(tex),'position',[14    14   879   762])
for run=1%:4
%  plot(S11_cau{run},S22_cau{run},'g-','LineWidth',3)
for load_ind=1:length(load_type)
plot(stress11{load_ind}(1:16),stress22{load_ind}(1:16),'b-','linewidth',3)
% 
% plot(stress11{1}(1:16),stress22{1}(1:16),'b-','linewidth',3)
% plot(stress11{4}(1:16),stress22{4}(1:16),'b-','linewidth',3)
%   plot(stress11{5}(1:16),stress22{5}(1:16),'b-','linewidth',3)
%   plot(stress11{8}(1:16),stress22{8}(1:16),'b-','linewidth',3)
%   plot(stress11{11}(1:16),stress22{11}(1:16),'b-','linewidth',3)
%   
%     plot(stress11{6}(1:16),stress22{6}(1:16),'b--','linewidth',3)
% 
%   plot(stress11{3}(1:16),stress22{3}(1:16),'g-','linewidth',3)
%   plot(stress11{9}(1:16),stress22{9}(1:16),'g-','linewidth',3)
%   
%     plot(stress11{2}(1:18),stress22{2}(1:18),'r-','linewidth',3)
%     plot(stress11{7}(1:18),stress22{7}(1:18),'r-','linewidth',3)
%   plot(stress11{10}(1:18),stress22{10}(1:18),'r-','linewidth',3)
%   plot(stress11{1}(1:18),stress22{1}(1:18),'r-','linewidth',3)
%     plot(stress11{11}(1:18),stress22{11}(1:18),'r-','linewidth',3)

hold on
grid on
end
end

figure
for m=1%[3,9]%[2,3,7,9,10]
    plot(E11{m},E22{m},'b-','LineWidth',3)
    hold on
    grid on
end
plot([0:0.01:0.25],feval(y2,[0:0.01:0.25]),'k-')

saveas (gcf,[path_dir,BC_name,slash_dir,filename_post,'.fig'])
% legend('BB-11-1','BB-11-2','BB-11-3','BB','BB-22-3','BB-22-2','BB-22-1')


% saveas(fig_str(tex),['C:\Users\mnp3\Documents\AA5754\BC\',BC_name,'/',texture(tex,1:7),'/',texture(tex),'_YS.fig'])
% saveas(fig_str(tex),['D:\CMU-NIST\Multijunction\VPSC7b\BC_Multi_5\',BC_name,'\',texture(tex,1:7),'\AA5754_YS.fig'])



filename_post=[BC_name,texture(tex,1:7),'_post_',date,'.mat'];
save ([path_dir,BC_name,'\',filename_post])
end
