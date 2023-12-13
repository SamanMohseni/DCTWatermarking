%Saman mohseni 9430713

function NC = NC_project(S, W1D)

%Because the numbers are binary, square error equals 0 if
%both numbers are equal, and 1 if the numbers are different
MSE = mean(S ~= W1D);

NC = 1 - MSE;
