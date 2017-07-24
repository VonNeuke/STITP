%抽取context features 从概率图中
function [ context_features ] = context_from_map(map_prob,n_size_image,num_image,path_pos,options)
         temp_map = reshape(map_prob,n_size_image(1),n_size_image(2),num_image*n_size_image(3));
         first = 1;
         second = n_size_image(3);
         for i = n_size_image(3) :n_size_image(3): num_image*n_size_image(3)
             %temp_map_prob = temp_map_prob(pos(:,i));
             %temp_map_prob = reshape(temp_map_prob,n_size_image(1),n_size_image(2),n_size_image(3));
             %获取部分图像
             z = 1;
             for j = first:second
                 temp_image(:,:,z) = temp_map(:,:,j);
                 z = z + 1;
             end
             first = i + 1;
             second = i + n_size_image(3);
             %获取坐标
             if  exist('options','var')
                 if ~isfield(options,'all')
                     pos = 1:n_size_image(1)*n_size_image(2)*n_size_image(3);
                     pos = pos(:);
                 end
             else
                 if path_pos ~= 0
                     num = round(i/n_size_image(3));
                     pos = load_data(path_pos,num);%pos为索引
                 else
                     error('检测是否需要使用all_pos')
                 end
             end
             temp_context = cal_context_features( temp_image , pos ,'index' );
             if i == n_size_image(3)
                 context_features = temp_context;
             else
                 context_features = [context_features;temp_context];
             end
             
         end
end