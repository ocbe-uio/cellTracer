function gui_h = track_acrossallimages_GUI()
%% TRACK_ACROSSALLIMAGES_GUI - creates graphic interface for tracking 
% no inputs
% OUTPUT
% gui_h - handles to gui

% Creates empty window only with menu:
% gui_h = guidata(track_acrossallimages_GUI_MENU); 
gui_h.figure1 = figure;
set(gui_h.figure1, 'Name',getVer)
set(gui_h.figure1, 'Toolbar','none')
set(gui_h.figure1, 'MenuBar','none')
set(gui_h.figure1, 'Units','pixels')

% Default size of window:
win_size = getWindowSizeFromJsonFile();

set(gui_h.figure1, 'Position',  win_size)
drawnow()
set(gui_h.figure1, 'Resize', 'on')

%%
gui_h.preprocessingpanel = uipanel('Parent', gui_h.figure1,...
'Title', 'Pre Processing method',...
'FontWeight', 'bold',...
'Units', 'Normalized', 'Position', [0.01, .85 .1 .1]);

gui_h.method_watershed = uicontrol('Parent', gui_h.preprocessingpanel,...
  'Style', 'checkbox', 'Units', 'Normalized','Value',1,...
'Position', [0 .5 1 .5],'String', 'Watershed',...
'HorizontalAlignment', 'Left', 'Tag', 'method_watershed');

gui_h.method_thresholding = uicontrol('Parent', gui_h.preprocessingpanel,...
  'Style', 'checkbox', 'Units', 'Normalized','Value', 0,...
'Position', [0 .0 1 .5],'String', 'Auto Threshold',...
'HorizontalAlignment', 'Left', 'Tag', 'method_thresholding');

%%
gui_h.whattoshowpanel = uipanel('Parent', gui_h.figure1,...
  'Units', 'Normalized', 'Position', [0.01, .65 .1 .15],...
  'FontWeight', 'bold',...
  'Title', 'What to show?');

gui_h.ShowRaw = uicontrol('Parent', gui_h.whattoshowpanel,...
  'Style', 'checkbox', 'Units', 'Normalized','Value', 1,...
'Position', [0 .65 1 .3],'String', 'Raw Image');

gui_h.ShowProcessed = uicontrol('Parent', gui_h.whattoshowpanel,...
  'Style', 'checkbox', 'Units', 'Normalized','Value', 1,...
'Position', [0 .35 1 .3],'String', 'Processed image');

gui_h.showCalculations = uicontrol('Parent', gui_h.whattoshowpanel,...
 'Style', 'pushbutton','String', 'Show calculations',...
 'Units', 'Normalized',...
 'Position', [0.1 0.05 .8 .3]); 


%% backroundcolorpanel
gui_h.backroundcolorpanel = uipanel('Parent', gui_h.figure1,...
  'Units', 'Normalized', 'Position', [0.01, .5 .1 .1],...
  'FontWeight', 'bold',...
  'Title', 'Background color');

gui_h.colormap = uicontrol('Parent', gui_h.backroundcolorpanel,...
 'Style', 'popup','String', {'parula','jet','hsv','hot','cool',...
 'spring','summer','autumn','winter','gray','bone','copper','pink'},...
 'Units', 'Normalized', 'Position', [0.1 0.05 .8 .8], 'Value',1); 

%%  celltrackpositionpanel
gui_h.celltrackpositionpanel = uipanel('Parent', gui_h.figure1,...
  'Units', 'Normalized', 'Position', [0.01, 0 .1 .45],...
  'FontWeight', 'bold',...
  'Title', 'Cell Track Position');

gui_h.xy_listbox = uicontrol('Parent', gui_h.celltrackpositionpanel,...
  'Style','listbox',...
  'Units', 'Normalized',...
  'Position', [0 0.1 1 .8]);
gui_h.xy_listbox_descriptionText =...
  uicontrol('Parent', gui_h.celltrackpositionpanel,...
  'Style','text',...
  'String', sprintf('[ Image | Xpos | YPos ]'),...
  'HorizontalAlignment', 'left',...
  'Units', 'Normalized','Position', [0 .9 1 .1]);

gui_h.ResetCalculations = uicontrol('Parent', gui_h.celltrackpositionpanel,...
  'Style', 'pushbutton',...
  'String', 'Reset (X-Y) Calculations',...
  'Units', 'Normalized', 'Position', [0.1 0 0.8 .1]);

%% rectanglesizepanel
gui_h.rectanglesizepanel = uipanel('Parent',gui_h.figure1,...
  'Title', 'Rectangle size',...
  'FontWeight', 'bold',...
  'Units','Normalized', 'Position', [.12 .2 .12 .05]);

gui_h.rectangle_size_slider = uicontrol('Parent', gui_h.rectanglesizepanel,...
  'Style', 'slider', 'Units', 'Normalized',...
  'Value', 70, 'Min', 50, 'Max', 90,... 
  'Position', [0 0 1 1]);

%% trackingpanel
gui_h.trackingpanel = uipanel('Parent',gui_h.figure1,...
  'Title', 'Control Tracking',...
  'FontWeight', 'bold',...
  'Units','Normalized', 'Position', [.3 0 .4 .2]);

gui_h.use_centre_of_mass_checkbox = uicontrol('Parent', gui_h.trackingpanel,...
  'Style', 'checkbox',...
  'String', 'Use Centre Of mass after manual correction',...
  'Value', 1,...
  'Units', 'Normalized', 'Position', [0.01 .75 .4 .15]);

gui_h.previous_pushbutton = uicontrol('Parent', gui_h.trackingpanel,...
  'Style', 'pushbutton','String', '<',...
  'Units', 'Normalized', 'Position', [0.01 .4 .3 .25]);

gui_h.next_pushbutton = uicontrol('Parent', gui_h.trackingpanel,...
  'Style', 'pushbutton', 'String', '>',...
  'Units', 'Normalized', 'Position', [.3 .4 .3 .25]);
  
gui_h.progress_txt = uicontrol('Parent',gui_h.trackingpanel,...
  'Style','Text','String','progress_txt ',...
  'HorizontalAlignment',...
  'left', 'FontWeight','bold',...
  'Units','Normalized', 'Position', [0.01 .22 .6 .15]);

gui_h.progress_slider = uicontrol('Parent', gui_h.trackingpanel,...
  'Style','slider','Value',1,'Min', 1, 'Max', 10, ...
  'Units', 'Normalized','Position', [0.01 0.02 .6 .2]);

gui_h.const_togglebutton = uicontrol('Parent', gui_h.trackingpanel,...
  'Style', 'togglebutton',...
    'String', 'Automated Tracking',...
    'Units', 'Normalized', 'Position',[.65 .4 .3 .5]);
  
gui_h.CenterView_pushbutton = uicontrol('Parent',gui_h.trackingpanel,...
  'Style','pushbutton','String','centre view ->xy<-', ...
  'Units','Normalized','Position',[.65 .1 .3 .2]);

%% CellDivisionPanel
gui_h.CellDivisionPanel = uipanel('Parent',gui_h.figure1,...
  'Title','Cell Division Panel','FontSize',8, 'Position',[.8 .2 .15 .6]);
% 
gui_h.Undo_CellDivision_pushbutton = uicontrol('Parent',...
  gui_h.CellDivisionPanel,'Style','pushbutton',...
  'String','Undo Cell Division', 'Units',...
  'Normalized','Position',[0.2 0 .6 .05]);

gui_h.CellDivision_pushbutton = uicontrol('Parent',gui_h.CellDivisionPanel,...
  'Style','pushbutton','String','Cell Division', 'Units','Normalized',...
  'Position',[0.2 0.05 .6 .1]);

%
gui_h.SaveAndClose = uicontrol('Parent',gui_h.figure1,'Style','pushbutton',...
  'String', 'Save & Close','Units','Normalized','Position', [.90 .95 .1 .05]);

gui_h.Cancel = uicontrol('Parent',gui_h.figure1,'Style','pushbutton',...
  'String', 'Cancel','Units','Normalized','Position', [.9 .9 .1 .05]);
% 
gui_h.s(1) = subplot(1,6,1,   'Parent', gui_h.figure1);
gui_h.s(2) = subplot(1,6,2:3, 'Parent', gui_h.figure1);
gui_h.s(3) = subplot(1,6,4:5, 'Parent', gui_h.figure1);


% gui_h.RectText = uicontrol('Parent',gui_h.figure1,'Style','Text','String',' ',...
%   'Units','Normalized', 'Position', [.25 .04 .2 .03], 'HorizontalAlignment',...
%   'left', 'FontWeight','bold');

% gui_h.preprocessingtext = uicontrol('Parent', gui_h.figure1,...
%   'Style', 'text', 'Units', 'Normalized',...
% 'Position', [0 .95 .15 .05],'String', 'Pre Processing method:',...
% 'HorizontalAlignment', 'Left', 'FontWeight', 'Bold');


% gui_h.method_watershed = uicontrol('Parent', gui_h.figure1,...
%   'Style', 'checkbox', 'Units', 'Normalized','Value',1,...
% 'Position', [0 .9 .1 .05],'String', 'Watershed',...
% 'HorizontalAlignment', 'Left', 'Tag', 'method_watershed');
% 
% gui_h.method_thresholding = uicontrol('Parent', gui_h.figure1,...
%   'Style', 'checkbox', 'Units', 'Normalized','Value', 0,...
% 'Position', [0 .85 .1 .05],'String', 'Auto Threshold',...
% 'HorizontalAlignment', 'Left', 'Tag', 'method_thresholding');

% uicontrol('Parent', gui_h.figure1,...
%   'Style', 'text', 'Units', 'Normalized','Value', 1,...
% 'Position', [.01 .25 .07 .1],'String', 'Show:',...
% 'HorizontalAlignment', 'Left','HandleVisibility', 'off');

% gui_h.ShowRaw = uicontrol('Parent', gui_h.figure1,...
%   'Style', 'checkbox', 'Units', 'Normalized','Value', 1,...
% 'Position', [.01 .25 .1 .05],'String', 'Raw Image');
% 
% gui_h.ShowProcessed = uicontrol('Parent', gui_h.figure1,...
%   'Style', 'checkbox', 'Units', 'Normalized','Value', 1,...
% 'Position', [.01 .2 .1 .05],'String', 'Processed image');
% 
% gui_h.showCalculations = uicontrol('Parent', gui_h.figure1,...
%  'Style', 'pushbutton','String', 'Show calculations',...
%  'Units', 'Normalized', 'Position', [.01 0.12 .1 .04]); 

% gui_h.colormap = uicontrol('Parent', gui_h.figure1,...
%  'Style', 'popup','String', {'parula','jet','hsv','hot','cool',...
%  'spring','summer','autumn','winter','gray','bone','copper','pink'},...
%  'Units', 'Normalized', 'Position', [.01 0.06 .1 .04], 'Value',1); 

% gui_h.rectangle_size_slider = uicontrol('Parent', gui_h.figure1,...
%   'Style', 'slider', 'Units', 'Normalized','Value', 70,'Min', 50, 'Max', 90,... 
%   'Position', [.25 .0 .15 .04]);
% 
% gui_h.RectText = uicontrol('Parent',gui_h.figure1,'Style','Text','String',' ',...
%   'Units','Normalized', 'Position', [.25 .04 .2 .03], 'HorizontalAlignment',...
%   'left', 'FontWeight','bold');

% gui_h.progress_slider = uicontrol('Parent', gui_h.figure1, 'Style',...
%   'slider','Value',1,'Min', 1, 'Max', 10, 'Units', 'Normalized',...
%   'Position', [.42 0 .2 .04]);
% 
% gui_h.progress_txt = uicontrol('Parent',gui_h.figure1,'Style','Text','String',' ',...
%   'Units','Normalized', 'Position', [.49 .04 .1 .03], 'HorizontalAlignment',...
%   'left', 'FontWeight','bold');
% 
% gui_h.previous_pushbutton = uicontrol('Parent', gui_h.figure1, 'Style', 'pushbutton',...
%   'String', '<', 'Units', 'Normalized', 'Position', [.65 0 .1 .04]);
% 
% gui_h.use_centre_of_mass_checkbox = uicontrol('Parent', gui_h.figure1, 'Style', 'checkbox',...
%   'String', 'Use Centre Of mass after manual correction','Value', 1,...
%   'Units', 'Normalized', 'Position', [.65 0.04 .2 .04]);
% 
% gui_h.next_pushbutton = uicontrol('Parent', gui_h.figure1, 'Style', 'pushbutton',...
%     'String', '>', 'Units', 'Normalized', 'Position', [.75 0 .1 .04]);
% 
% gui_h.const_togglebutton = uicontrol('Parent', gui_h.figure1, 'Style', 'togglebutton',...
%     'String', 'Automated Tracking', 'Units', 'Normalized', 'Position',[.85 0 .1 .04]);
%   
% gui_h.CenterView_pushbutton = uicontrol('Parent',gui_h.figure1,'Style',...
%   'pushbutton','String','centre view ->xy<-', ...
%   'Units','Normalized','Position',[.85 0.04 .1 .04]);

% gui_h.CellDivisionPanel = uipanel('Parent',gui_h.figure1,...
%   'Title','Cell Division Panel','FontSize',8, 'Position',[.8 .2 .17 .65]);

% gui_h.CellDivisionPanel = uipanel('Parent',gui_h.figure1,...
%   'Title','Cell Division Panel','FontSize',8, 'Position',[.8 .5 .18 .45]);
% % 
% gui_h.Undo_CellDivision_pushbutton = uicontrol('Parent',...
%   gui_h.CellDivisionPanel,'Style','pushbutton',...
%   'String','Undo Cell Division', 'Units',...
%   'Normalized','Position',[0.2 0 .6 .05]);
% 
% gui_h.CellDivision_pushbutton = uicontrol('Parent',gui_h.CellDivisionPanel,...
%   'Style','pushbutton','String','Cell Division', 'Units','Normalized',...
%   'Position',[0.2 0.05 .6 .1]);

% xy_listbox_pos = [0.85 0.18 0.1 0.23];
% gui_h.xy_listbox = uicontrol(gui_h.figure1,'Style','listbox',...
%   'Units', 'Normalized','Position', xy_listbox_pos);
% xyPos = xy_listbox_pos;
% xyPos(2) = xy_listbox_pos(2) + xy_listbox_pos(4);
% xyPos(4) = 0.06;
% gui_h.xy_listbox_descriptionText = uicontrol(gui_h.figure1,'Style','text',...
%   'Units', 'Normalized','Position', xyPos,...
%   'String', sprintf('  Cell Track Positon: \n[ Image | Xpos | YPos ]'), 'HorizontalAlignment', 'left');

% gui_h.SaveAndClose = uicontrol('Parent',gui_h.figure1,'Style','pushbutton',...
%   'String', 'Save & Close','Units','Normalized','Position', [.90 .95 .1 .05]);
% 
% gui_h.Cancel = uicontrol('Parent',gui_h.figure1,'Style','pushbutton',...
%   'String', 'Cancel','Units','Normalized','Position', [.90 .9 .1 .05]);
% 
% % gui_h.ResetCalculations = uicontrol('Parent', gui_h.figure1,'Style', 'pushbutton',...
% %   'String', 'Reset (X-Y) Calculations', 'Units', 'Normalized', 'Position', [.85 0.09 .1 .04]);
% 
% gui_h.s(1) = subplot(1,6,1,   'Parent', gui_h.figure1);
% gui_h.s(2) = subplot(1,6,2:3, 'Parent', gui_h.figure1);
% gui_h.s(3) = subplot(1,6,4:5, 'Parent', gui_h.figure1);
