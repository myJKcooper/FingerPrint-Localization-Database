clc
clear
%% 读取数据
[num,txt,raw] = xlsread('C:\Users\86138\Desktop\DasicData\project5\1\1.xlsx'); 
log_1=string(raw);
L=ismissing(log_1);
L1=find(L);
log_1(L1)=' ';
%% 提取经纬度
[m,n] = size(log_1);
judgement_1 = 'LT';  
a_1 = strcmp(judgement_1,log_1);
b_1 = find(a_1==1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 纬度数值（分为度分秒）之后用于米勒投影
lati_point = b_1-m-3;
lati_1 = str2double(log_1(lati_point));
lati_degree = fix(lati_1/100);                        %度
lati_minute = fix(lati_1-lati_degree*100);            %分
lati_second = (lati_1-lati_degree*100-lati_minute)*60;%秒
lati = lati_degree+lati_minute/60+lati_second/3600; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 经度数值 (都省略显示为3.8518e+03，但实际上是原数值，没有四舍五入)
long_point = b_1-3;
long_1 = str2double(log_1(long_point));
long_degree = fix(long_1/100);
long_minute = fix(long_1-long_degree*100);
long_second = (long_1-long_degree*100-long_minute)*60;
long = long_degree+long_minute/60+long_second/3600;
popoint1 = [long lati]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 经纬度画图
lon = popoint1(:,1); %经度
lat = popoint1(:,2); %纬度
webmap OpenStreetMap;
wmline(lat, lon, 'Color', 'b', 'Width', 3);
wmmarker(lat(1), lon(1), 'Color', 'g'); %起点标识绿色
wmmarker(lat(end), lon(end), 'Color', 'r'); %终点标识红色
%% 提取servingcell的cellid,pcid,rsrp,rsrq,rssi,sinr
judgement_2 = 'LT';  
a_2 = strcmp(judgement_2,log_1);
b_2 = find(a_2==1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cellid
cellid_point_se = b_2+4*m;
cellid_se_all= log_1(cellid_point_se);
cellid_se=zeros(size(cellid_se_all));
for i = 1:size(cellid_se_all,1)
    if size(char(cellid_se_all(i)),2) == 7     %char函数把双引号字符串改为单引号字符串方便对字符串运用函数
        cellid_se(i) = hex2dec(cellid_se_all(i));
    else
        cellid_se(i) = nan;
    end
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% pcid
pcid_point_se = b_2+5*m;
pcid_se = str2double(log_1(pcid_point_se));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% earfcn
% earfcn_point_se = b_2+6*m;
% earfcn_se = str2double(log_1(earfcn_point_se));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rsrp
rsrp_point_se = b_2+11*m;
rsrp_se = str2double(log_1(rsrp_point_se));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rsrq
rsrq_point_se = b_2+12*m;
rsrq_se = str2double(log_1(rsrq_point_se));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rssi
rssi_point_se = b_2+13*m;
rssi_se = str2double(log_1(rssi_point_se));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sinr
sinr_point_se = b_2+14*m;
sinr_se = str2double(log_1(sinr_point_se));

data_se=[lati,long,cellid_se,pcid_se,rsrp_se,rsrq_se,rssi_se,sinr_se];
%% 提取neighbourcell的earfcn,pcid,rsrp,rsrq,rssi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ne1
earfcn_point_ne1 = b_2+3;
earfcn_ne1 = str2double(log_1(earfcn_point_ne1));
pcid_point_ne1 = b_2+3+m;
pcid_ne1 = str2double(log_1(pcid_point_ne1));
rsrq_point_ne1 = b_2+3+2*m;
rsrq_ne1 = str2double(log_1(rsrq_point_ne1));
rsrp_point_ne1 = b_2+3+3*m;
rsrp_ne1 = str2double(log_1(rsrp_point_ne1));
rssi_point_ne1 = b_2+3+4*m;
rssi_ne1 = str2double(log_1(rssi_point_ne1));
data_ne1 = [earfcn_ne1,pcid_ne1,rsrq_ne1,rsrp_ne1,rssi_ne1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ne2
earfcn_point_ne2 = b_2+4;
earfcn_ne2 = str2double(log_1(earfcn_point_ne2));
pcid_point_ne2 = b_2+4+m;
pcid_ne2 = str2double(log_1(pcid_point_ne2));
rsrq_point_ne2 = b_2+4+2*m;
rsrq_ne2 = str2double(log_1(rsrq_point_ne2));
rsrp_point_ne2 = b_2+4+3*m;
rsrp_ne2 = str2double(log_1(rsrp_point_ne2));
rssi_point_ne2 = b_2+4+4*m;
rssi_ne2 = str2double(log_1(rssi_point_ne2));
data_ne2 = [earfcn_ne2,pcid_ne2,rsrq_ne2,rsrp_ne2,rssi_ne2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ne3
% pcid_point_ne3 = b_2+5+m;
% pcid_ne3 = str2double(log_1(pcid_point_ne3));
% rsrq_point_ne3 = b_2+5+2*m;
% rsrq_ne3 = str2double(log_1(rsrq_point_ne3));
% rsrp_point_ne3 = b_2+5+3*m;
% rsrp_ne3 = str2double(log_1(rsrp_point_ne3));
% rssi_point_ne3 = b_2+5+4*m;
% rssi_ne3 = str2double(log_1(rssi_point_ne3));
% data_ne3 = [pcid_ne3,rsrq_ne3,rsrp_ne3,rssi_ne3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ne4
% rsrq_point_ne4 = b_2+6+2*m;
% rsrp_point_ne4 = b_2+6+3*m;
% rssi_point_ne4 = b_2+6+4*m;
% rsrq_ne4 = str2double(log(rsrq_point_ne4));
% rsrp_ne4 = str2double(log(rsrp_point_ne4));
% rssi_ne4 = str2double(log(rssi_point_ne4));
% data_ne4 = [rsrq_ne4,rsrp_ne4,rssi_ne4];
%% 数据处理
data_se=[lati,long,cellid_se,pcid_se,rsrp_se,rsrq_se,rssi_se,sinr_se];
data_ne1 = [earfcn_ne1,pcid_ne1,rsrq_ne1,rsrp_ne1,rssi_ne1];
data_ne2 = [earfcn_ne2,pcid_ne2,rsrq_ne2,rsrp_ne2,rssi_ne2];

kkk_1=find(isnan(lati));
kkk_2=find(isnan(cellid_se));
kkk_3=find(isnan(pcid_se));
kkk_4=find(isnan(rsrq_se));
kkk_5=find(isnan(sinr_se));
kkk_6=find(pcid_se==0);

kkk_7=find(isnan(rsrp_ne1));
kkk_8=find(isnan(rssi_ne1));
kkk_9=find(pcid_ne1==0);
kkk_10=find(rsrq_ne1==0);

kkk_11=find(isnan(pcid_ne2));
kkk_12=find(isnan(rssi_ne2));
kkk_13=find(pcid_ne2==0);
kkk_14=find(rsrq_ne2==0);

kkk=[kkk_1',kkk_2',kkk_3',kkk_4',kkk_5',kkk_6',kkk_7',kkk_8',kkk_9',kkk_10',kkk_11',kkk_12',kkk_13',kkk_14']';   
[Y,T]=sort(kkk);
kkk1=unique(Y);
delepoint = kkk1;                %把所有的NAN点的全部统计出来  

for i = 1:length(b_1)           %去除所有的NAN点，并且匹配数据
    for ii = 1:length(delepoint)
        if i == delepoint(ii)
            lati(i) = [];
            long(i) = [];
            
            cellid_se(i) = [];
            pcid_se(i) = [];
            rsrp_se(i) = [];
            rsrq_se(i) = [];
            rssi_se(i) = [];
            sinr_se(i) = [];
            
            earfcn_ne1(i) = [];
            pcid_ne1(i) = [];
            rsrq_ne1(i) = [];
            rsrp_ne1(i) = [];
            rssi_ne1(i) = [];
            
            earfcn_ne2(i) = [];
            pcid_ne2(i) = [];
            rsrq_ne2(i) = [];
            rsrp_ne2(i) = [];
            rssi_ne2(i) = [];
            
            delepoint = delepoint-1; %%%%%%每运行一次矩阵lati long lac rxlev等 维数减一所以delepoint要减一以匹配nan点
        end
    end
end

Data5_se_1=[long,lati,cellid_se,pcid_se,rsrp_se,rsrq_se,rssi_se,sinr_se];   %Data2_se_1  2代表第二次采集数据 1代表第二次采集数据第一个 以此类推
Data5_ne1_1 = [earfcn_ne1,pcid_ne1,rsrq_ne1,rsrp_ne1,rssi_ne1];
Data5_ne2_1 = [earfcn_ne2,pcid_ne2,rsrq_ne2,rsrp_ne2,rssi_ne2];

%%
save( 'C:\Users\86138\Desktop\DasicData\project5\1\Data5_1.mat','Data5_se_1','Data5_ne1_1','Data5_ne2_1');


lon = Data5_se_1(:,1); %经度
lat = Data5_se_1(:,2); %纬度
webmap OpenStreetMap;
wmline(lat, lon, 'Color', 'b', 'Width', 3);
wmmarker(lat(1), lon(1), 'Color', 'g'); %起点标识绿色
wmmarker(lat(end), lon(end), 'Color', 'r'); %终点标识红色


