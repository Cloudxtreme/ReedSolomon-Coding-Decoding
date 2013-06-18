% RS Encoder

clear all;
close all;

%% Init
%dati casuali
data = [ 0 1 2 3 4 5 6 7 8];

m = 4; %Numero di bit per simbolo
n = 2^m -1; %Lunghezza della codeword
k = 9;     %Lunghezza del messaggio

% Allora il codice corregge 2 errori

% Polinomio primitivo che genera il campo
primitive = 19; % 10011 -> D^4 + D + 1

msg = gf(data,m,primitive);

%rspoly

%% First Test
%Simple encoding decoding
% First test

disp('Test 1');

c1 = rsenc(msg,n,k); %Encoding
[rec1,nerr1] = gf_bsc(c1,m,0.02,20);
d1 = rsdec(rec1,n,k); %deconding

disp(['Probability : ' '2%']);
disp('Number of errors : ');
disp(nerr1);    

if isequal(d1,msg) == 1
    disp('All ok!');
else
    disp('Not recovered!');
end

%% Second Test
% Entroducing 1 error
disp('Test 2');

c2 = rsenc(msg,n,k);
[rec2,nerr2] = gf_bsc(c2,m,0.05,20);
d2 = rsdec(rec2,n,k);

disp(['Probability : ' '5%']);
disp('Number of errors : ');
disp(nerr2);    

if isequal(d2,msg) == 1
    disp('All ok!');
else
    disp('Not recovered!');
end


%% Third Test
disp('Test 3');

c3 = rsenc(msg,n,k);
[rec3,nerr3] = gf_bsc(c3,m,0.075,20);
d3 = rsdec(rec3,n,k);

disp(['Probability : ' '7.5%']);
disp('Number of errors : ');
disp(nerr3);    

if isequal(d3,msg) == 1
    disp('All ok!');
else
    disp('Not Recovered!');
end

clear c3
clear d3

%% Fourth Test
% Heavy noise channel

c4 = rsenc(msg,n,k);
[rec4,nerr4] = gf_bsc(c4,m,0.1,22);
d4 = rsdec(rec4,n,k);

disp(['Probability : ' '10%']);
disp('Number of errors : ');
disp(nerr4);    

if isequal(d4,msg) == 1
    disp('All ok!');
else
    disp('Not Recovered!');
end
