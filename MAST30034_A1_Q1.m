clear all;close all;clc
%% question1.1
TC1 = [ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1);
       ones(15,1);zeros(15,1)];
TC1 = (TC1 - mean(TC1)) / std(TC1);

TC2 = [zeros(20,1);
       ones(20,1); zeros(25,1);
       ones(20,1); zeros(25,1);
       ones(20,1); zeros(25,1);
       ones(20,1); zeros(25,1);
       ones(20,1); zeros(20,1)];
   
TC2 = (TC2 - mean(TC2)) / std(TC2);
   
TC3 = [ones(25,1);zeros(35,1);
       ones(25,1);zeros(35,1);
       ones(25,1);zeros(35,1);
       ones(25,1);zeros(35,1)];
TC3 = (TC3 - mean(TC3)) / std(TC3);

TC4 = [ones(15,1);zeros(25,1);
       ones(15,1);zeros(25,1);
       ones(15,1);zeros(25,1);
       ones(15,1);zeros(25,1);
       ones(15,1);zeros(25,1);
       ones(15,1);zeros(25,1)];
TC4 = (TC4 - mean(TC4)) / std(TC4);

TC5 = [ones(20,1);zeros(20,1);
       ones(20,1);zeros(20,1);
       ones(20,1);zeros(20,1);
       ones(20,1);zeros(20,1);
       ones(20,1);zeros(20,1);
       ones(20,1);zeros(20,1)];
TC5 = (TC5 - mean(TC5)) / std(TC5);


TC6  = [ones(25,1);zeros(15,1);
       ones(25,1);zeros(15,1);
       ones(25,1);zeros(15,1);
       ones(25,1);zeros(15,1);
       ones(25,1);zeros(15,1);
       ones(25,1);zeros(15,1)];
TC6 = (TC6 - mean(TC6)) / std(TC6);
figure
subplot(3,2,1); plot(TC1);axis([0 250 -2 2]);title('TC1')
subplot(3,2,2); plot(TC2);axis([0 250 -2 2]);title('TC2')
subplot(3,2,3); plot(TC3);axis([0 250 -2 2]);title('TC3')
subplot(3,2,4); plot(TC4);axis([0 250 -2 2]);title('TC4')
subplot(3,2,5); plot(TC5);axis([0 250 -2 2]);title('TC5')
subplot(3,2,6); plot(TC6);axis([0 250 -2 2]);title('TC6')

%% question-1.2
TC = [TC1 TC2 TC3 TC4 TC5 TC6];
R = corrcoef(TC);
figure
heatmap(R)

%% question-1.3

tmpSM = zeros(6,21,21);
tmpSM(1,2:6,2:6) = 1;
tmpSM(2,2:6,15:19) = 1;
tmpSM(3,8:13,2:6) = 1;
tmpSM(4,8:13,15:19) = 1;
tmpSM(5,15:19,2:6) = 1;
tmpSM(6,15:19,15:19) = 1;

figure
for i = 1 : 1 : 6
    subplot(3,2,i);
    heatmap(squeeze(tmpSM(i,:,:)))
end
SM = reshape(tmpSM,[6,441]);

R = corrcoef(SM');
figure
heatmap(R)
%% question-1.4
mu=0;sigma=0.25;
Tao_t = sigma *randn(240,6)+mu;
mu=0;sigma=0.015;
Tao_s = sigma *randn(6,441)+mu;

R = corrcoef(Tao_t);
figure
heatmap(R)

R = corrcoef(Tao_s');
figure
heatmap(R)

histogram(Tao_t) 
histogram(Tao_s) 
heatmap(Tao_t * Tao_s)
%% question-1.5
X = (TC + Tao_t) * (SM + Tao_s);
[m,n] = size(X);
index = randsample(n,100);
figure
for i = 1 : 1 : length(index)
    plot(X(:,index(i)));hold on
end
var_s = [];
for i = 1 : 1 : n
    var_s = [var_s var(X(:,i))];
end
figure 
plot(var_s)
X = normalize(X,1);

save('TC.mat','TC')
save('X.mat','X')