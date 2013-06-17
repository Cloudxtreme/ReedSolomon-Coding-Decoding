%%Init
%Calculate polynomial

clear all;
close all;

m =4 ; %% Size of GF 2^4
n = 2^m -1 ;
k = 9;
prim_poly = 19; % 10011 -> D^4+D+1

mat_poly = [ 1 1;
    1 2;
    1 4;
    1 8;
    1 3;
    1 6];

msg = [0 1 2 3 4 5 6 7 8];
error = [1 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
mm = -1;

%% Start
[rows,cols] = size(mat_poly);

gen_poly = gf(mat_poly(1:1,1:2),m);

for i = 2:rows
    
    temp_p = gf(mat_poly(i:i,1:2),m);
    gen_poly = conv(gen_poly,temp_p);
    
end

%Clear
clear cols

%% Generating matrix

temp_copy = gen_poly.x;

temp_copy = temp_copy(rows+1:-1:1);

gen_mat = [];

%%Adding zeros
for i = rows+1:n-1
   
    temp_copy = [temp_copy 0];
    
end

for i = rows:n-1
    
    gen_mat = [gen_mat ; temp_copy];
    temp_copy = circshift(temp_copy,[0 1]);
    
end

gen_mat = gf(gen_mat,m);

clear temp_copy

%% Building parity matrix

parity_mat = [];
first_row = mat_poly(1:rows,2:2)'; %Estraggo i B
first_row = gf(first_row,m); % Galois field

for i = 0:n-1
    
    parity_mat = [parity_mat; power(first_row,i)];

end

ris = gen_mat*parity_mat;

%Check ci sono diversi problemi
if sum(ris.x)== 1
    disp('Ok gen_mat e parity_mat stanno ok!');
else
    disp('Mmmh qualcosa non va controlla i tuoi calcoli!');
end

clear first_row
clear ris

%% Encoding usando il codice sistematico

%Coding a word

msg_send = msg;

%%Adding zeros
for i = k:n-1
   
     msg_send = [msg_send 0];
     
end

%msg_send = circshift(msg_send,[0 n-k]);
msg_send = gf(msg_send,m);

[quot,rem] = deconv(msg_send,gen_poly);

% Now msg_send belongs to C, 
msg_send = msg_send - rem;

%for
display('Codewod to send');
display(msg_send);

%% Channel

error_gf = gf(error,m);
msg_recv = msg_send + error_gf;


%% Decoding

%calcolo le sindromi

syndromes = [];
beta = gf(2,m);

for i = mm+1:mm+(n+1)-k -1
    
    syndromes = [syndromes polyval(msg_recv,beta^i)];
    
end

% Se le sindromi sono tutte zero

if sum(syndromes.x) == 0
    display('Nessun errore, procedo normalmente nella decodifica');
else
    display('Si sono verificati errori');
end

% calcolo m'












