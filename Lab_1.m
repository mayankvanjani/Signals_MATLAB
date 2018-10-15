%%% Lab 1
clc
clear all

%% 1: Creating Vectors

A = [1 0 4 5 3 9 0 2];
fprintf("A: ");
%disp(A);
a = [4 5 0 2 0 0 7 1];
fprintf("a: ");
%disp(a);

%A.*a
% Use . when multiplying element wise

%%
B = [A, a];
fprintf("B: ");
%disp(B);
C = [a, A];
fprintf("C: ");
%disp(C);

%%
D = zeros(1,50);
%any checks if there are any non-0
fprintf("D: ");
%disp(D);
E = ones(1,100);
%all checks if there are any 0
fprintf("E: ");
%disp(E);

%%
F = [1:30];
fprintf("F: ");
%disp(F);
G = [25:-3:1];
% can also f = f(-1) or reverse(f)
fprintf("G: ");
%disp(G);
H = [0 : 0.2 : 2.0];
fprintf("H: ");
%disp(H);
fprintf('\n');

%% 2: Operations with Vectors

V1 = [1 2 3 4 5 6 7 8 9 0];
V2 = [0.3 1.2 0.5 2.1 0.1 0.4 3.6 4.2 1.7 0.9];
V3 = [4 4 4 4 3 3 2 2 2 1];

sum_V1 = sum(V1);
sum_V2 = sum(V2);
sum_V3 = sum(V3);

V1(5);
V2(5);
V3(5);

% V1(0);
% V1(11);

V4 = V2(1:5);
V5 = V2(6:10);

V6 = [V2(1:5), V2(7:10)];
V7 = [V2(1:6), [1.4], V2(8:10)];
V8 = V2(1:2:9);

9-V1;
V1*5;
V1+V2;
V1-V3;
V1.*V2;
%V1*V2;
V1.^2;
V1.^V3;
%V1^V3;
V1 == V3;
V1 > 6;
V1 > V3;
V3 - (V1 > V2);
(V1 > V2) & (V1 < 6);
(V1 > V2) | (V1 < 6);
any(V1);
all(V1);

%% 3: HELP

%% 4: Flow Control

A = zeros(1,5);
for n = 1:4
    for m = 1:3
        A = A + n*m;
        %disp(A);
    end
end
A

%%

B = [1 0];
if (all(B))
    B = B+1;
elseif (any(B))
    B = B+2;
else
    B = B+3
end
B

%%

C = 7:2:22;
num = 0;
while (all(C>0))
    C = C - 3;
    num = num + 1;
end
C
num

%%
for n = 1:100000
    x(n) = sin(n*pi/10);
end

n = 1:100000;
y = sin(n*pi/10);

%% 5: Scripts and Functions

% other files