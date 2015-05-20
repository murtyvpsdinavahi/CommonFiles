%% arrayCat = rowCat(array)
% Concatenates rows of the same array and returns a row vector
% Input: array: m-by-n matrix
% Output: arrayCat: 1-by-m*n matrix
%
% Created by Murty V P S Dinavahi 28/09/2015
%

function arrayCat = rowCat(array)
    arrayCat = [];
    for iR = 1:size(array,1)
        arrayCat = [arrayCat array(iR,:)];
    end
end