clc;
clear;

%% puma560
%%标准D-H模型
%       theta    d           a        alpha     offset
SL1=Link([0      0           0         -pi/2       0     ],'standard');
SL2=Link([0      0           100       0           0     ],'standard');
SL3=Link([0      20          10        -pi/2       0     ],'standard');
SL4=Link([0      100         0         pi/2        0     ],'standard');
SL5=Link([0      0           0         -pi/2       0     ],'standard');
SL6=Link([0      0           0         0           0     ],'standard');

%定义关节范围
SL1.qlim =[-pi/2, pi/2];
SL2.qlim =[-pi/2, pi/2];
SL3.qlim =[-pi/2, pi/2];
SL4.qlim =[-pi/2, pi/2];
SL5.qlim =[-pi/2, pi/2];
SL6.qlim =[-pi/2, pi/2];

q1_min = -pi/2; q1_max = pi/2;
q2_min = -pi/2; q2_max = pi/2;
q3_min = -pi/2; q3_max = pi/2;
q4_min = -pi/2; q4_max = pi/2;
q5_min = -pi/2; q5_max = pi/2;
q6_min = -pi/2; q6_max = pi/2;

p560=SerialLink([SL1 SL2 SL3 SL4 SL5 SL6],'name','puma560');

%可视化puma机械臂
p560
figure(1)
qz =[0 , 0 , 0 , 0 , 0 , 0];
p560.plot(qz);

%用蒙特卡罗法画出工作空间
q_min = [q1_min q2_min q3_min q4_min q5_min q6_min];
q_max = [q1_max q2_max q3_max q4_max q5_max q6_max];

for i = 0:1:10000
    q = q_min + (q_max - q_min).*rand(1,6);
    T = p560.fkine(q);
    p = transl(T);
    plot3(p(1),p(2),p(3),'b.');
    grid on;
    hold on;
end
