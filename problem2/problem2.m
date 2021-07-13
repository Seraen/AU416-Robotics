clc;
clear;

%% puma560
%%标准D-H模型
%       theta    d           a        alpha     offset
SL1=Link([0      0           0         pi/2       0     ],'standard');
SL2=Link([0      0           100       0           0     ],'standard');
SL3=Link([0      20          10        -pi/2       0     ],'standard');
SL4=Link([0      100         0         pi/2        0     ],'standard');
SL5=Link([0      0           0         -pi/2       0     ],'standard');
SL6=Link([0      0           0         0           0     ],'standard');

p560=SerialLink([SL1 SL2 SL3 SL4 SL5 SL6],'name','puma560');

%可视化puma机械臂
p560
figure(1)
qz=[0,0,0,0,0,0];
p560.plot(qz);
grid on;
hold on;


%设置障碍
figure(1)
plotcube([200,30,150],[100,0,50],.8,[1,0,0]);
xlim([-200 400]);
ylim([-200 200]);
zlim([-200 200]);
grid on;
hold on;

%选取起点、中间点和终点，取得关节空间矩阵
T1=transl(100, 100, 10) * trotx(pi);
T2=transl(80, 0, 10) * trotx(pi/2);
T3=transl(100, -100, 10) * trotx(pi/2);
q1=p560.ikine6s(T1);
q2=p560.ikine6s(T2);
q3=p560.ikine6s(T3);
Q=[q1;q2;q3]

%三次插值求路径中21点的关节空间值
q_c=[];
for i=1:6
    ty=Q(:,i);
    ty=ty';
    tx=1:3;
    tx1=1:0.1:3;
    q_c(i,:)=interp1(tx,ty,tx1,'PCHIP');
end
q_c=q_c';
q=[q_c];
figure(1)
p560.plot(q);

%画轨迹
figure(1)
JTA=transl(p560.fkine(q));
t=[0:0.05:1]';
plot3(JTA(:,1).',JTA(:,2).',JTA(:,3).','b*');
hold on;

figure(2)
plot(t, q(:,2));
qplot(t,q);
