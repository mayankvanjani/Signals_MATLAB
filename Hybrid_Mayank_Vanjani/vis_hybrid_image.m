function output = vis_hybrid_image(hybrid_image)
%visualize a hybrid image by progressively downsampling the image and
%concatenating all of the images together.

scales = 10;         % How many downsampled versions to create
scale_factor = 0.8;  % How much to downsample each time
padding = 5;         % How many pixels to pad.

original_height = size(hybrid_image,1);
num_colors      = size(hybrid_image,3); %counting how many color channels the input has
output    = hybrid_image;
cur_image = hybrid_image;

for i = 2:scales
    
    % Add padding
    output = cat(2, output, ones(original_height, padding, num_colors));
    
    % Dowsample image;
    cur_image = imresize(cur_image, scale_factor, 'bilinear');
    
    % Pad the top and append to the output
    tmp = cat(1,ones(original_height - size(cur_image,1), size(cur_image,2), num_colors), cur_image);
    
    output = cat(2, output, tmp);    
end


%code by James Hays