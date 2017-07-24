function [ data ] = load_image(path)
   data = load(path);
   data = data.temp_data;
end