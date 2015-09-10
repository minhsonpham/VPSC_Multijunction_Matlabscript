%%Plotting the evolution of dislocation interactions
f_cop=@(x)(1-22/10)*exp(-1*x)+22/10
f_col=@(x)(6-22/10)*exp(-x)+22/10
f_h=@(x)(5.1-22/10)*exp(-x)+22/10
f_lc=@(x)(8.1-22/10)*exp(-x)+22/10
f_multi=@(x)0*x+22/10

figure
plot([0:1:5],feval(f_col,[0:1:5]),'b-','LineWidth',3)
hold on
grid on
plot([0:1:5],feval(f_lc,[0:1:5]),'g-','LineWidth',3)
plot([0:1:5],feval(f_h,[0:1:5]),'r-','LineWidth',3)
plot([0:1:5],feval(f_cop,[0:1:5]),'k-','LineWidth',3)
plot([5:1:20],feval(f_multi,[5:1:20]),'r--','LineWidth',3)

set(gca,'FontSize',16,'fontweight','b')
legend('COL','LC','H','Other binary junctions','Multi-junction')
xlabel('\it{\epsilon} %','FontSize',20,'fontweight','b')
ylabel('Junction strength','FontSize',20,'fontweight','b')

system('/users/mnp3/vpsc/Codes/VPSC7b_July2013/VPSC7');

system(['/users/mnp3/vpsc/AA5754/COD\ files/Model/wts2cod.sh']);


%------------reading experimental values of stress--------------------%

    fid_RD=fopen('/users/mnp3/vpsc/AA5754/OPT/BBRD.txt'); 
        BBRD_stress= textscan(fid_RD,'%f %f');
        S11_exp=BBRD_stress{1,2};
    fclose(fid_RD);
    
    fid_TD=fopen('/users/mnp3/vpsc/AA5754/OPT/BBTDJAN12.txt'); 
        BBTD_stress= textscan(fid_TD,'%f');
        S22_exp=BBTD_stress{1,1};
    fclose(fid_TD);
    %------------STRSTR-END-------------------%

run_total=1;
fid=fopen('STR_STR.OUT'); % loaded file should locate at the working directory. 
        STRSTR{run_total,1}= textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',...
            'Delimiter','whitespace','MultipleDelimsAsOne',1,'HeaderLines',1);
        Evm{run_total,1}=STRSTR{run_total,1}{1,1};
        Svm{run_total,1}=STRSTR{run_total,1}{1,2};

        E11{run_total,1}=STRSTR{run_total,1}{1,3};
        S11{run_total,1}=STRSTR{run_total,1}{1,9};

        E22{run_total,1}=STRSTR{run_total,1}{1,4};
        S22{run_total,1}=STRSTR{run_total,1}{1,10};
fclose(fid);

figure('Name','S22 vs S11')
subplot(1,2,1)
hold on
    grid on
    box on
plot(E11{run_total,1}*100,S11{run_total,1}-STRSTR{run_total,1}{1,11},'k-','linewidth',3);
legend('Exp','Modelling')
set(gca,'FontSize',14,'fontweight','b')
ylabel('\sigma_{11} (MPa)','FontSize',20,'fontweight','b')
xlabel('\epsilon_{11} (%)','FontSize',20,'fontweight','b')
subplot(1,2,2)
hold on
    grid on
plot(E22{run_total,1}*100,S22{run_total,1}-STRSTR{run_total,1}{1,11},'r-*','linewidth',3);
legend('Exp','Modelling')
set(gca,'FontSize',14,'fontweight','b')
ylabel('\sigma_{22} (MPa)','FontSize',20,'fontweight','b')
xlabel('\epsilon_{22} (%)','FontSize',20,'fontweight','b')
axis square
axis square
box on

axis([0 40 0 500])