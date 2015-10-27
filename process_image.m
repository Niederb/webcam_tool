function process_image( image, cb1_val, cb2_val, p1_val, p2_val, p3_val)
   p1_val = 255*p1_val;
   gray_scale = rgb2gray(image);
   mask = (gray_scale > p1_val);
   mask_eroded = mask;
   
   st_size = 1 + round(3*p3_val);
   if cb2_val == 1
       st = strel('diamond', st_size);
   else
       st = strel('disk', st_size);
   end
   if (cb1_val == 1)
       for i=1:(10*p2_val)
        
        
        mask_eroded = imerode(mask_eroded, st);
       end
   end
   
   pan on
   zoom on
   %output images
   %axes(parent_handle);
   ax1 = subplot(2, 2, 1);
   imshow(image);%, 'parent', parent_handle);
   ax2 = subplot(2, 2, 2);
   imshow(mask);%, 'parent', parent_handle)
   ax3 = subplot(2, 2, 3);
   imshow(mask_eroded);%, 'parent', parent_handle)   
   ax4 = subplot(2, 2, 4);
   imshow(1 - mask_eroded);%, 'parent', parent_handle)   
   linkaxes([ax1, ax2, ax3, ax4], 'xy');