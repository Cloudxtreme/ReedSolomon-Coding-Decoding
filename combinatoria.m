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

p1 = 0.1;


c1 = rsenc(msg,n,k); %Encoding

% Sending message throught a binary symmetric channel
%[ndata1,err1] = bsc(c1.x,p1);
d1 = rsdec(c1,n,k); %deconding

if isequal(d1,msg) == 1
    disp('All ok!');
end

%% Second Test
% Entroducing 1 error
disp('Test 2');

c2 = rsenc(msg,n,k);

d2 = rsdec(c2,n,k);

if isequal(d2,msg) == 1
    disp('All ok!');
end


%% Third Test


