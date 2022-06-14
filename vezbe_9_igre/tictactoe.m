function varargout = tictactoe(varargin)
% TICTACTOE M-file for tictactoe.fig
%      TICTACTOE, by itself, creates a new TICTACTOE or raises the existing
%      singleton*.
%
%      H = TICTACTOE returns the handle to a new TICTACTOE or the handle to
%      the existing singleton*.
%
%      TICTACTOE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TICTACTOE.M with the given input arguments.
%
%      TICTACTOE('Property','Value',...) creates a new TICTACTOE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tictactoe_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tictactoe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tictactoe

% Last Modified by GUIDE v2.5 03-Nov-2004 08:09:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tictactoe_OpeningFcn, ...
                   'gui_OutputFcn',  @tictactoe_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before tictactoe is made visible.
function tictactoe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tictactoe (see VARARGIN)

% Choose default command line output for tictactoe
handles.output = hObject;
set(hObject,'Color',[0.0    0.251    0.502]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tictactoe wait for user response (see UIRESUME)
% uiwait(handles.MTTT);


% --- Outputs from this function are returned to the command line.
function varargout = tictactoe_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
initialize_board(handles,0);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,1)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,2)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,3)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,4)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,5)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,6)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,7)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,8)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
picksquare(handles,9)

function picksquare(handles,num)
for i=1:9
    set(eval(['handles.pushbutton' int2str(i)]),'Enable','off');
end
avsq=getappdata(gcbf,'avsq');
avsq(find(avsq==num))=[];
setappdata(gcbf,'avsq',avsq);
turn=getappdata(gcbf,'turn');
nop=getappdata(gcbf,'nop');
set(eval(['handles.pushbutton' int2str(num)]),'Visible','off');
board=getappdata(gcbf,'board');
board=board';
board(num)=turn;
board=board';
axes(eval(['handles.axes' int2str(num)]))
img=imread([int2str(turn) '.jpg']);
image(img);
axis off
if turn==1
    turn=2;
    set(handles.dispturn,'String','Player O choose a square');
elseif turn==2
    turn=1;
    set(handles.dispturn,'String','Player X choose a square');
end
setappdata(gcbf,'turn',turn);
setappdata(gcbf,'board',board);
[win,squares]=checkboard(board);

if win~=0

	if win==1
       set(handles.dispturn,'String','Player X wins!!!');
       score=str2double(get(handles.xscore,'String'));
       score=score+1;
       set(handles.xscore,'String',int2str(score));
    elseif win==2
       set(handles.dispturn,'String','Player O wins!!!');
       score=str2double(get(handles.oscore,'String'));
       score=score+1;
       set(handles.oscore,'String',int2str(score));
	end
    set(handles.newgame,'Enable','on');
	for i=1:9
        set(eval(['handles.pushbutton' int2str(i)]),'Enable','off');
	end
    img=imread([int2str(win+2) '.jpg']);
    for i=1:3
        axes(eval(['handles.axes' int2str(squares(i))]))
        image(img);
        axis off
    end
end



if win==0
	inichk=0;
	for i=1:9
        a=get(eval(['handles.pushbutton' int2str(i)]),'Visible');
        if a(1:2)=='of'
            inichk=inichk+1;
        end
	end
	if inichk==9
       set(handles.dispturn,'String','Tie Game.');
       set(handles.newgame,'Enable','on');
	end
    
    if nop==1 & turn==2 & inichk<9
        decision(handles,avsq);
    end

	for i=1:9
        set(eval(['handles.pushbutton' int2str(i)]),'Enable','on');
	end
end

function [win,squares]=checkboard(b)
b=b';
win=0;
squares=[0 0 0];

for i=1:2
    if b(1)==i & b(2)==i & b(3)==i
        win=i;
        squares=[1 2 3];
    elseif b(4)==i & b(5)==i & b(6)==i
        win=i;
        squares=[4 5 6];
    elseif b(7)==i & b(8)==i & b(9)==i
        win=i;
        squares=[7 8 9];
    elseif b(1)==i & b(4)==i & b(7)==i
        win=i;
        squares=[1 4 7];
    elseif b(2)==i & b(5)==i & b(8)==i
        win=i;
        squares=[2 5 8];
    elseif b(3)==i & b(6)==i & b(9)==i
        win=i;
        squares=[3 6 9];
    elseif b(1)==i & b(5)==i & b(9)==i
        win=i;
        squares=[1 5 9];
    elseif b(3)==i & b(5)==i & b(7)==i
        win=i;
        squares=[3 5 7];
    end
end

function initialize_board(handles,chk)
for i=1:9
    set(eval(['handles.pushbutton' int2str(i)]),'Visible','on');
    set(eval(['handles.pushbutton' int2str(i)]),'Enable','off');
    axes(eval(['handles.axes' int2str(i)]))
    cla;
    axis off;
end
set(handles.newgame,'Enable','off');

if chk==0
	for i=1:9
        set(eval(['handles.pushbutton' int2str(i)]),'Enable','off');
        set(handles.newgame,'Enable','on');
	end
end


% --- Executes on button press in newgame.
function newgame_Callback(hObject, eventdata, handles)
% hObject    handle to newgame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chk=1;

if isempty(get(handles.dispturn,'String'))==1
    sturn=2;
    setappdata(gcbf,'sturn',sturn);
    nop=get(handles.getnop,'Value');
    iskill=get(handles.beginner,'checked');
    if iskill(1:2)=='on'
        skill=1;
        setappdata(gcbf,'skill',skill);
        set(handles.beginner,'checked','on');
        set(handles.intermediate,'checked','off');
        set(handles.expert,'checked','off');
    end
    if nop==1
        chk=0;
    else
        nop=nop-1;
        setappdata(gcbf,'nop',nop);
        set(handles.getnop,'Enable','off');
    end
end

if chk==1
	
	initialize_board(handles,1);
	
	sturn=getappdata(gcbf,'sturn');
    nop=getappdata(gcbf,'nop');
	
	if sturn==1
        set(handles.dispturn,'String','Player O choose a square');
        sturn=2;
	elseif sturn==2
        set(handles.dispturn,'String','Player X choose a square');
        sturn=1;
	end
	setappdata(gcbf,'sturn',sturn);
	setappdata(gcbf,'turn',sturn);
	
	nxtnum=0;
	setappdata(gcbf,'nxtnum',nxtnum);
	board=zeros(3,3);
	board=board';
	setappdata(gcbf,'board',board);
    avsq=[1:9];
	setappdata(gcbf,'avsq',avsq);
    
    if nop==2 | (nop==1 & sturn==1)
       	for i=1:9
            set(eval(['handles.pushbutton' int2str(i)]),'Enable','on');
    	end
    end

    if nop==1 & sturn==2
        decision(handles,avsq);
    end

    
end

% --- Executes during object creation, after setting all properties.
function getnop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to getnop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in getnop.
function getnop_Callback(hObject, eventdata, handles)
% hObject    handle to getnop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns getnop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from getnop


function decision(handles,avsq)
pause(1)
skill=getappdata(gcbf,'skill');
tr=0;
b=getappdata(gcbf,'board');
b=b';

num=0;
nxtnum=0;
i=1;
j=2;

while num==0
    if i==1     
    	s=[1 2 3];
    elseif i==2
    	s=[4 5 6];
    elseif i==3
    	s=[7 8 9];
    elseif i==4
    	s=[1 4 7];
    elseif i==5
    	s=[2 5 8];
    elseif i==6
    	s=[3 6 9];
    elseif i==7
    	s=[1 5 9];
    elseif i==8
    	s=[3 5 7];
    elseif i==9 & j==2
        j=1;
        i=0;
    elseif i==9 & j==1
        num=10;
    end
	
	if b(s(1))==j & b(s(2))==j & b(s(3))==0
        num=s(3);
	elseif b(s(1))==j & b(s(3))==j & b(s(2))==0
        num=s(2);
	elseif b(s(2))==j & b(s(3))==j & b(s(1))==0
        num=s(1);
	end
    i=i+1;
end

as=length(avsq);

if skill==1
    a=35;
elseif skill==2
    a=65;
elseif skill==3
    a=95;
end

if as==9
    prob=ceil(rand*100);
    if prob<=a
        tr=ceil(rand*3);
       	setappdata(gcbf,'tr',tr);
    end
elseif as==8
    prob=ceil(rand*100);
    if prob<=a
        tr=4;
    end
elseif as==7
    tr=getappdata(gcbf,'tr');
elseif as==5 | as==6
    nxtnum=getappdata(gcbf,'nxtnum');    
    tr=0;
else
    tr=0;
end


if num==10

    %First Move
    if as==9
        if tr==1
            s=[1 3 7 9];
            num=s(ceil(rand*4));
        elseif tr==2
            s=[2 4 6 8];
            num=s(ceil(rand*4));
        elseif tr==3
            num=5;
        end
    end

    %Second Move
    if as==7
        if tr==1
            for i=1:4
                if i==1
                    s=[1 2 4];
                    ss=[1 3 4 7 2];
                    sss=[1 5 6 8];
                    ssss=[1 6 7 8 3];
                    sssss=[1 9 3 7];
                elseif i==2
                    s=[3 2 6];
                    ss=[3 1 6 9 2];
                    sss=[3 5 4 8];
                    ssss=[3 4 9 8 1];
                    sssss=[3 7 1 9];
                elseif i==3
                    s=[7 4 8];
                    ss=[7 1 8 9 4];
                    sss=[7 5 2 6];
                    ssss=[7 2 9 6 1];
                    sssss=[7 3 1 9];
                elseif i==4
                    s=[9 6 8];
                    ss=[9 3 8 7 6];
                    sss=[9 5 2 4];
                    ssss=[9 2 7 4 3];
                    sssss=[9 1 3 7];
                end
                if b(s(1))==2 & b(s(2))==1
                    num=s(3);
                    nxtnum=5;
                elseif b(s(1))==2 & b(s(3))==1
                    num=s(2);
                    nxtnum=5;
                elseif b(ss(1))==2 & b(ss(2))==1
                    num=ss(3);
                    nxtnum=5;
                elseif b(ss(1))==2 & b(ss(4))==1
                    num=ss(5);
                    nxtnum=5;
                elseif b(sss(1))==2 & b(sss(2))==1
                    num=sss(ceil(rand*2)+2);
                elseif b(ssss(1))==2 & b(ssss(2))==1
                    num=ssss(3);
                    nxtnum=5;
                elseif b(ssss(1))==2 & b(ssss(4))==1
                    num=ssss(5);
                    nxtnum=5;
                elseif b(sssss(1))==2 & b(sssss(2))==1
                    n=ceil(rand*2);
                    if n==1
                        num=sssss(3);
                        nxtnum=sssss(4);
                    elseif n==2
                        num=sssss(4);
                        nxtnum=sssss(3);
                    end
                end
            end
        elseif tr==2
            for i=1:4
                if i==1
                    s=[2 4 1 6 3];
                    ss=[2 7 1 9 3];
                    sss=[2 5 7 9];
                elseif i==2
                    s=[4 2 1 8 7];
                    ss=[4 3 1 9 7];
                    sss=[4 5 3 9];
                elseif i==3
                    s=[6 2 3 8 9];
                    ss=[6 1 3 7 9];
                    sss=[6 5 1 7];
                elseif i==4
                    s=[8 4 7 6 9];
                    ss=[8 1 7 3 9];
                    sss=[8 5 1 3];
                end
                if b(s(1))==2 & b(s(2))==1
                    num=s(3);
                    nxtnum=5;
                elseif b(s(1))==2 & b(s(4))==1
                    num=s(5);
                    nxtnum=5;
                elseif b(ss(1))==2 & b(ss(2))==1
                    num=ss(3);
                elseif b(ss(1))==2 & b(ss(4))==1
                    num=ss(5);
                elseif b(sss(1))==2 & b(sss(2))==1
                    n=ceil(rand*2);
                    if n==1
                        num=sss(3);
                    elseif n==2
                        num=sss(4);
                    end
                end
            end
        elseif tr==3
            for i=1:4
                if i==1
                    s=[5 2 4 1 7 6 3 9];
                    ss=[5 1 9 10];
                elseif i==2
                    s=[5 4 2 1 3 8 7 9];
                    ss=[5 3 7 10];
                elseif i==3
                    s=[5 8 4 1 7 6 3 9];
                    ss=[5 7 3 10];
                elseif i==4
                    s=[5 6 2 1 3 8 7 9];
                    ss=[5 9 1 10];
                end
                if b(s(1))==2 & b(s(2))==1
                    n=ceil(rand*2);
                    nn=ceil(rand*2);
                    if n==1
                        num=s(3);
                        if nn==1
                            nxtnum=s(4);
                        elseif nn==2
                            nxtnum=s(5);
                        end
                    elseif n==2
                        num=s(6);
                        if nn==1
                            nxtnum=s(7);
                        elseif nn==2
                            nxtnum=s(8);
                        end
                    end
                elseif b(ss(1))==2 & b(ss(2))==1
                    num=ss(3);
                    nxtnum=ss(4);
                end
            end
        end
    end

    %Third Move
    if as==5 & nxtnum~=0
        if nxtnum==10
            if b(2)==1 & b(1)==2
                num=7;
            elseif b(2)==1 & b(3)==2
                num=9;
            elseif b(4)==1 & b(1)==2
                num=3;
            elseif b(4)==1 & b(7)==2
                num=9;
            elseif b(6)==1 & b(3)==2
                num=1;
            elseif b(6)==1 & b(9)==2
                num=7;
            elseif b(8)==1 & b(7)==2
                num=1;
            elseif b(8)==1 & b(9)==2
                num=3;
            end
        else
            num=nxtnum;
        end
    end

    %Blocks
    if tr==4
        for i=1:4
            if i==1
                s=[1 5];
                ss=[2 1 3 5];
            elseif i==2
                s=[3 5];
                ss=[4 1 5 7];
            elseif i==3
                s=[7 5];
                ss=[6 3 5 9];
            elseif i==4
                s=[9 5];
                ss=[8 5 7 9];
            end
            if b(s(1))==1
                num=s(2);
                nxtnum=10;
            elseif b(ss(1))==1
                n=ceil(rand*3)+1;
                num=ss(n);
                nxtnum=10;
            elseif b(5)==1
                sss=[1 3 7 9];
                n=ceil(rand*4);
                num=sss(n);
                nxtnum=10;
            end
        end
    end
    
    %Block 2
    if as==6 & nxtnum==10
        for i=1:4
            if i==1
                s=[1 9 5];
                ss=[1 5 9 3 7];
                sss=[2 1 3 5];
                ssss=[2 5 4 1 6 3];
                sssss=[1 5 8 7 6 3];
            elseif i==2
                s=[1 9 5];
                ss=[3 5 7 1 9];
                sss=[4 1 7 5];
                ssss=[4 5 2 1 8 7];
                sssss=[3 5 8 9 4 1];
            elseif i==3
                s=[3 7 5];
                ss=[7 5 3 1 9];
                sss=[6 3 9 5];
                ssss=[6 5 2 3 8 9];
                sssss=[7 5 2 1 6 9];
            elseif i==4
                s=[3 7 5];
                ss=[9 5 1 3 7];
                sss=[8 7 9 5];
                ssss=[8 5 4 7 6 9];
                sssss=[9 5 2 3 4 7];
            end
            if b(s(1))==1 & b(s(2))==1 & b(s(3))==2
                sp=[2 4 6 8];
                num=sp(ceil(rand*4));    
            elseif b(ss(1))==2 & b(ss(2))==1 & b(ss(3))==1
                n=ceil(rand*2)+3;
                num=ss(n);
            elseif b(sss(1))==1 & (b(sss(2))==2 | b(sss(3))==2) & b(5)==0
                num=5;
            elseif b(ssss(1))==1 & b(ssss(2))==2 & b(ssss(3))==1
                num=ssss(4);
            elseif b(ssss(1))==1 & b(ssss(2))==2 & b(ssss(5))==1
                num=ssss(6);
            elseif b(sssss(1))==1 & b(sssss(2))==2 & b(sssss(3))==1
                num=sssss(4);
            elseif b(sssss(1))==1 & b(sssss(2))==2 & b(sssss(4))==1
                num=sssss(5);
            end
        end
    end
    
    %Other Move
    if num==10
        num=avsq(ceil(length(avsq)*rand));
    end

    
end

setappdata(gcbf,'nxtnum',nxtnum);
picksquare(handles,num);


% --------------------------------------------------------------------
function filemenu_Callback(hObject, eventdata, handles)
% hObject    handle to filemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function resetgame_Callback(hObject, eventdata, handles)
% hObject    handle to resetscore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.getnop,'Value',1);
set(handles.getnop,'Enable','on');
set(handles.dispturn,'String','');
set(handles.xscore,'String','0');
set(handles.oscore,'String','0');
initialize_board(handles,0);


% --------------------------------------------------------------------
function beginner_Callback(hObject, eventdata, handles)
% hObject    handle to beginner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.beginner,'checked','on');
set(handles.intermediate,'checked','off');
set(handles.expert,'checked','off');
setappdata(gcbf,'skill',1);

% --------------------------------------------------------------------
function intermediate_Callback(hObject, eventdata, handles)
% hObject    handle to intermediate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.beginner,'checked','off');
set(handles.intermediate,'checked','on');
set(handles.expert,'checked','off');
setappdata(gcbf,'skill',2);

% --------------------------------------------------------------------
function expert_Callback(hObject, eventdata, handles)
% hObject    handle to expert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.beginner,'checked','off');
set(handles.intermediate,'checked','off');
set(handles.expert,'checked','on');
setappdata(gcbf,'skill',3);

% --------------------------------------------------------------------
function exitgame_Callback(hObject, eventdata, handles)
% hObject    handle to exitgame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.MTTT)


% --------------------------------------------------------------------
function aboutinfo_Callback(hObject, eventdata, handles)
% hObject    handle to aboutinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function versioninfo_Callback(hObject, eventdata, handles)
% hObject    handle to versioninfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

abouttictactoe;
