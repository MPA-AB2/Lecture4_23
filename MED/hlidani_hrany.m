dim = res{1};
imshow(dim);
sdim = sum(dim);
for i = 1:sdim
    if sdim(i) > 0
        offset = i-1;
        break;
    end
end