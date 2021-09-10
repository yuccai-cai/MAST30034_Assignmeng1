clear all;close all;clc
load('X.mat')
load('TC.mat')
D = TC;
A_LSR = inv(D'*D) * D' * X;
D_LSR = X * A_LSR';
figure
subplot(1,2,1);
heatmap(reshape(A_LSR(1,:),21,21));
subplot(1,2,2);
plot(A_LSR(1,:))

figure
subplot(1,2,1);
heatmap(reshape(A_LSR(2,:),21,21));
subplot(1,2,2);
plot(A_LSR(2,:))

figure
subplot(1,2,1);
heatmap(reshape(A_LSR(3,:),21,21));
subplot(1,2,2);
plot(A_LSR(3,:))

figure
subplot(1,2,1);
heatmap(reshape(A_LSR(4,:),21,21));
subplot(1,2,2);
plot(A_LSR(4,:))

figure
subplot(1,2,1);
heatmap(reshape(A_LSR(5,:),21,21));
subplot(1,2,2);
plot(A_LSR(5,:))

figure
subplot(1,2,1);
heatmap(reshape(A_LSR(6,:),21,21));
subplot(1,2,2);
plot(A_LSR(6,:))


figure
subplot(3,2,1);plot(D_LSR(:,1))
subplot(3,2,2);plot(D_LSR(:,2))
subplot(3,2,3);plot(D_LSR(:,3))
subplot(3,2,4);plot(D_LSR(:,4))
subplot(3,2,5);plot(D_LSR(:,5))
subplot(3,2,6);plot(D_LSR(:,6))

figure
scatter(D_LSR(:,3),X(:,30));

figure
scatter(D_LSR(:,4),X(:,30));

%% 2-2
lamda = 1000;
ARR = inv(D'*D + lamda * eye(6)) * D' * X;
c_tlsr = [];
for i = 1 : 1 : 6
    a = [];
    for j = 1 : 1 : 6
        d = corrcoef(TC(:,i),D_LSR(:,j));
        a = [a d(1,2)];
    end
    c_tlsr = [c_tlsr max(a)];
end
figure
plot(ARR(1,:));hold on
plot(A_LSR(1,:))
legend('ARR','A_LSR')

%% 2-3
% s = 1 / (1.1 * D'*D);
aa = [];
for rou = 0:0.05:1
    
V = 441;
N = 240;
ss = X - rou * D_LSR * A_LSR;
sum = 0;
for i = 1 : 1 : V
    sum = sum + norm(ss(:,i),2)^2;
end
aa = [ aa sum / (V*N)];
end
figure
plot(0:0.05:1,aa);
xlabel('rou')
ylabel('mse')
%% 2-4
figure
plot(ARR(1,:));hold on
plot(A_LSR(1,:))
legend('ARR','A_LSR')
%% 2-5
rou = 0.001;
a = TC'*TC;
figure
plot(eig(a))