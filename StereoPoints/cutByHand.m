function cutByHand(img_str)
    imObj = imread(img_str);
    figure%('KeyReleaseFcn', @ImageClickUp); %this doesnt trigger at all
    imageHandle = imshow(imObj);
    set(imageHandle,'ButtonDownFcn',@ImageClickDown);
    %set(h,'KeyReleaseFcn',@ImageClickUp);
    set(gcf, 'WindowButtonUpFcn',@ImageClickUp);
      function ImageClickDown ( objectHandle , eventData )
          axesHandles  = get(objectHandle,'Parent');
          coordinate = get(axesHandles,'CurrentPoint'); 
          coordinate = coordinate(1,1:2);
          setappdata(gcf,'down', coordinate);
      end
      function ImageClickUp ( objectHandle , eventData )
          %axesHandle  = get(objectHandle,'Parent');
          coordinates = get(objectHandle,'CurrentPoint'); 
          coordinates = coordinates(1,1:2);
          down=getappdata(gcf,'down');
          up=coordinates;
          %do stuff with up and down
      end
end