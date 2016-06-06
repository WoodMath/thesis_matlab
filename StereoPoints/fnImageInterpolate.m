function [ img_t ] = fnImageInterpolate( st_data, f_t )
%fnImageInterpolate Summary of this function goes here
%   Detailed explanation goes here
    img_source = st_data.Source.ImageData;
    img_dest = st_data.Destination.ImageData;

    %% Get points
    vRC_source = reshape([st_data.Points.Source], [2, length(st_data.Points)])';
    vRC_dest = reshape([st_data.Points.Destination], [2, length(st_data.Points)])';

    if(~isequal(size(st_data.Source.ImageData), size(st_data.Destination.ImageData)))
        return
    end
    img_t = zeros(size(img_source), class(img_source));

    %% Info needed for borders
    vRC_size = size(st_data.Source.ImageData);

    v_append = [1, 1; vRC_size(1), 1; 1, vRC_size(2); vRC_size(1), vRC_size(2)];
    vRC_source_use = [vRC_source; v_append];
    vCR_source_use = [vRC_source_use(:,2), vRC_source_use(:,1)];

    vIDX_source = delaunay(vCR_source_use);
    
    vRC_dest_use = [vRC_dest; v_append];
    vCR_dest_use = [vRC_dest_use(:,2), vRC_dest_use(:,1)];

    
    for i_inc = 1:length(vIDX_source)
        
        idx_tri = vIDX_source(i_inc,:);
        if(max(idx_tri) > max([length(vCR_source_use),length(vCR_dest_use)]))
            error([' Index of ', max(idx_tri), ' is greater than size of points']);
        end

        v2_source = vRC_source_use(idx_tri',:);
        v2_dest = vRC_dest_use(idx_tri',:);
        [ img_tri ] = fnTriangleInterpolate(img_source, img_dest, v2_source, v2_dest, f_t);
        img_t = max(img_t, img_tri);
        
%         sfigure(4);
%         imshow(img_t);
%         set(gca, 'Visible', 'on');
    end
    

end

