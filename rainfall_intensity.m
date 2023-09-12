% Define the path to your GeoTIFF file
tif_file_path = 'CCS_1y2020.tif';

% Read the GeoTIFF file using the geotiffread function
rainfall_data = geotiffread(tif_file_path);

% Handle NoData values (-99 in your case)
rainfall_data(rainfall_data == -99) = NaN;

% Define the cell size (0.04 degrees) and the unit (mm)
cellsize = 0.04; % degrees
unit = 'mm';

% Define the spatial information
ncols = 14;
nrows = 13;
xllcorner = 76.840;
yllcorner = 28.400;
x_max = xllcorner + (ncols - 1) * cellsize;
y_max = yllcorner + (nrows - 1) * cellsize;
extent = [xllcorner, x_max, yllcorner, y_max];

% Load the shapefile
shapefile_path = 'Cbe2011Wards.shp';
S = shaperead(shapefile_path);

% Extract the bounding box of the shapefile
shapefile_x = [S.X];
shapefile_y = [S.Y];
shapefile_extent = [min(shapefile_x), max(shapefile_x), min(shapefile_y), max(shapefile_y)];

% Calculate the axis limits based on the shapefile extent
x_axis_limits = [max(extent(1), shapefile_extent(1)), min(extent(2), shapefile_extent(2))];
y_axis_limits = [max(extent(3), shapefile_extent(3)), min(extent(4), shapefile_extent(4))];

% Create a figure and display the rainfall data using imagesc within shapefile's dimensions
figure;
imagesc(extent(1:2), extent(3:4), rainfall_data);
colormap('jet'); % Use 'jet' colormap or replace with another colormap
colorbar;
xlabel('Longitude');
ylabel('Latitude');
title(['Satellite Precipitation Data (', unit, '/year)']);

% Set the axis limits to display within the shapefile's dimensions
axis([x_axis_limits, y_axis_limits]);

% Show the plot
axis xy; % Ensure the y-axis is displayed correctly
