function [offset] = get_offset(gray_image)
imsum = sum(gray_image);
for i = 1:length(imsum)
    if imsum(i) > 0
        offset = i-1;
        break;
    end
end
offset = length(imsum);