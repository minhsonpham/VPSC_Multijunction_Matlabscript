% This subroutine to create VPSC input file that dictates specific loading history path
% this subroutine is particular to create the history loading path file for
% VPSC run in Pham linux
% functions y(x) is to represent the strain paths
% load_type is a variable name its indices represent different paths
% In this subroutine, only conditions near to exact plane strain and
% equi-biaxial are generated. 

y1=@(x)0.3*(1-exp(-x/2))
y21=@(x)(1-exp(-x/2))
y22=@(x)(1-exp(-x/2))

y33=@(x)x/20
% y33=@(x)(1-exp(-x))
% plot([0:1:20],y([0:1:20]))

y_13=@(x)-0.018775*x-0.00033164;
[y_13(0.15), y_13(0.25)]
plot([0:0.01:0.17],y_13([0:0.01:0.17]),'k--','linewidth',3)

% % y_23=@(x)x/-16.945+0.0086482/-16.945;
y_23=@(x)x*(-16.945)+0.0086482;
% [y_23(0.15)/0.15, y_23(0.25)/0.25]
plot([0:-0.001:-0.0099],y_23([0:-0.001:-0.0099]),'b-','linewidth',3)

y_33=@(x)0.96594-0.00057988/x;
[y_33(0.15)/0.15, y_33(0.25)/0.25]


% load_type=['RDT00';'PSRm1';'PSRm0';'PSR00';'BB000';'PST00';'PSTm0';'PSTm1';'TDT00'];
load_type=['RDT00';'RDTm1';'PSRm1';'PSRm0';'PSR00';'BB000';'BBTRD';'PST00';'PSTm0';'PSTm1';'TDTm1';'TDT00'];

    figure
    plot(y33(0:17),'r-')
    hold on
    grid on
    
for load_ind=[2,3,7,10,11]
    if load_ind==2 % based on r value varying from 0.6 to 0.65, Mark paper
        L11=1.0+0.0*y21(0:25);
        L22=-0.375-0.019*y21(0:25);
        L33=-0.625+0.019*y21(0:25);
        
    elseif load_ind==3
        
% %         good for PS11
% %         L11=1.0*ones(1,18)+0.2*y21(0:17);
% %         L22=-0.19+0.12*y21(0:17);
        L11=1.0+0.2*y21(0:25);
        L22=-0.19+0.12*y21(0:25);
        L33=-(L11+L22);
    elseif load_ind==10
        L11=-0.2+0.17*y22(0:25);
        L22=1.05+0.2*y21(0:25);
        L33=-(L11+L22);
    elseif load_ind==7
        L11=0.90+0.35*y33(0:25);
        L22=1.1+0.1*y33(0:25);
        L33=-(L11+L22);
    elseif load_ind==11 % based on r value varying from 1 to 0.9, Mark paper
        L22=1.0+0.0*y21(0:25);
        L11=-0.5+0.026*y21(0:25);
        L33=-0.5-0.026*y21(0:25);
    end
    
%     plot(L11,L22)

% %     axis([0.5 1.5 0.5 1.5])
    
    if load_ind~=6
        step=28; % to write deformation step, 28 is the total lines including 2 headers for 25 def step
    else step=28;
    end
    
    fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/Loading/LIJ_HIST.DAT'],'r'); % reading the template of Loading condition
        for l=1:step
            line_load{load_ind}{l}=fgetl(fid_load);
            if l>2
                line_load{load_ind}{l}(7:17)=num2str(L11(l-2),'%+10.4E');
                line_load{load_ind}{l}(56:66)=num2str(L22(l-2),'%+10.4E');
                line_load{load_ind}{l}(103:113)=num2str(L33(l-2),'%+10.4E');
    
            end
        end
     fclose(fid_load);
            
    fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/Loading/LIJ_',load_type(load_ind,:),'.DAT'],'w+');
%         fid_load=fopen(['/home/minhsonpham/Documents/VPSC_code/VPSC7b_evolvingbinary/LIJ_',load_type(load_ind,:),'.DAT'],'w+');
    if load_ind~=5
        line_load{load_ind}{1}=' 25   7   0.01    298.         nsteps  ictrl  eqincr  temp';
        for i=1:28
        fprintf(fid_load,'%s \n',line_load{load_ind}{1,i});
        end
    else
        for i=1:28
        fprintf(fid_load,'%s \n',line_load{load_ind}{1,i});
        end
    end
        fclose(fid_load);
end