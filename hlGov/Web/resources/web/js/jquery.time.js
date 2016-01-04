//
var CalendarData=new Array(100);
var madd=new Array(12);
var tgString="甲乙丙丁戊己庚辛壬癸";
var dzString="子丑寅卯辰巳午未申酉戌亥";
var numString="一二三四五六七八九十";
var monString="正二三四五六七八九十冬腊";
var weekString="日一二三四五六";
var sx="鼠牛虎兔龙蛇马羊猴鸡狗猪";
var cYear,cMonth,cDay,TheDate;

function init()
{
  CalendarData = new Array(
                  0xA4B,0x5164B,0x6A5,0x6D4,0x415B5,0x2B6,0x957,0x2092F,0x497,0x60C96,    // 1921-1930
                  0xD4A,0xEA5,0x50DA9,0x5AD,0x2B6,0x3126E, 0x92E,0x7192D,0xC95,0xD4A,     // 1931-1940
                  0x61B4A,0xB55,0x56A,0x4155B, 0x25D,0x92D,0x2192B,0xA95,0x71695,0x6CA,   // 1941-1950
                  0xB55,0x50AB5,0x4DA,0xA5B,0x30A57,0x52B,0x8152A,0xE95,0x6AA,0x615AA,    // 1951-1960
                  0xAB5,0x4B6,0x414AE,0xA57,0x526,0x31D26,0xD95,0x70B55,0x56A,0x96D,      // 1961-1970
                  0x5095D,0x4AD,0xA4D,0x41A4D,0xD25,0x81AA5, 0xB54,0xB6A,0x612DA,0x95B,   // 1971-1980
                  0x49B,0x41497,0xA4B,0xA164B, 0x6A5,0x6D4,0x615B4,0xAB6,0x957,0x5092F,   // 1981-1990
                  0x497,0x64B, 0x30D4A,0xEA5,0x80D65,0x5AC,0xAB6,0x5126D,0x92E,0xC96,     // 1991-2000
                  0x41A95,0xD4A,0xDA5,0x20B55,0x56A,0x7155B,0x25D,0x92D,0x5192B,0xA95,    // 2001-2010
                  0xB4A,0x416AA,0xAD5,0x90AB5,0x4BA,0xA5B, 0x60A57,0x52B,0xA93,0x40E95);  // 2011-2020
          madd[0]=0;madd[1]=31;madd[2]=59;madd[3]=90;
          madd[4]=120;madd[5]=151;madd[6]=181;madd[7]=212;
          madd[8]=243;madd[9]=273;madd[10]=304;madd[11]=334;
 }

function GetBit(m,n) {  return (m>>n)&1; }

function e2c()
{

  TheDate= (arguments.length!=3) ? new Date() : new Date(arguments[0],arguments[1],arguments[2]);
  var total,m,n,k;
  var isEnd=false;
  var tmp=TheDate.getFullYear();
  if (tmp<1900)  { tmp+=1900;}
  total=(tmp-1921)*365+Math.floor((tmp-1921)/4)+madd[TheDate.getMonth()]+TheDate.getDate()-38;
  if (TheDate.getFullYear()%4==0&&TheDate.getMonth()>1) { total++;}

  for(m=0;;m++)
  {
    k=(CalendarData[m]<0xfff)?11:12;
    for(n=k;n>=0;n--)
    {
      if(total<=29+GetBit(CalendarData[m],n))
      {
        isEnd=true; break;
      }
      total=total-29-GetBit(CalendarData[m],n);
    }
    if(isEnd) break;
  }

  cYear=1921 + m; cMonth=k-n+1; cDay=total;
  if(k==12)
   {
    if(cMonth==Math.floor(CalendarData[m]/0x10000)+1) { cMonth=1-cMonth; }
    if(cMonth>Math.floor(CalendarData[m]/0x10000)+1)  { cMonth--; }
   }
}

function GetcDateString()
{ var tmp="";
  //tmp+=tgString.charAt((cYear-4)%10);   //年干
  //tmp+=dzString.charAt((cYear-4)%12);   //年支
  //tmp+="(";
 // tmp+=sx.charAt((cYear-4)%12);
  //tmp+=")年 ";

  if(cMonth<1) { tmp+="(闰)"; tmp+=monString.charAt(-cMonth-1); } else {tmp+=monString.charAt(cMonth-1);}
  tmp+="月";
  tmp+=(cDay<11)?"初":((cDay<20)?"十":((cDay<30)?"廿":"三十")); /*卅*/
  if (cDay%10!=0||cDay==10) { tmp+=numString.charAt((cDay-1)%10); }
  return tmp;
}

init();
function GetLunarDay(solarYear,solarMonth,solarDay)
{
        if (solarYear<1921 || solarYear>2020)
        {
          return ""; //年份不在1921-2020范围，无法获得。
        }
        else
        {
          solarMonth = (parseInt(solarMonth)>0) ? (solarMonth-1) : 11;
          e2c(solarYear,solarMonth,solarDay); return GetcDateString();
        }
}
//
var bsYear;
var bsDate;
var bsWeek;
var arrLen=8; //数组长度
var sValue=0; //当年的秒数
var dayiy=0; //当年第几天
var miy=0; //月份的下标
var iyear=0; //年份标记
var dayim=0; //当月第几天
var spd=86400; //每天的秒数

var year1999="30;29;29;30;29;29;30;29;30;30;30;29"; //354
var year2000="30;30;29;29;30;29;29;30;29;30;30;29"; //354
var year2001="30;30;29;30;29;30;29;29;30;29;30;29;30"; //384
var year2002="30;30;29;30;29;30;29;29;30;29;30;29"; //354
var year2003="30;30;29;30;30;29;30;29;29;30;29;30"; //355
var year2004="29;30;29;30;30;29;30;29;30;29;30;29;30"; //384
var year2005="29;30;29;30;29;30;30;29;30;29;30;29"; //354
var year2006="30;29;30;29;30;30;29;29;30;30;29;29;30";

var month1999="正月;二月;三月;四月;五月;六月;七月;八月;九月;十月;十一月;十二月"
var month2001="正月;二月;三月;四月;闰四月;五月;六月;七月;八月;九月;十月;十一月;十二月"
var month2004="正月;二月;闰二月;三月;四月;五月;六月;七月;八月;九月;十月;十一月;十二月"
var month2006="正月;二月;三月;四月;五月;六月;七月;闰七月;八月;九月;十月;十一月;十二月"
var Dn="初一;初二;初三;初四;初五;初六;初七;初八;初九;初十;十一;十二;十三;十四;十五;十六;十七;十八;十九;二十;廿一;廿二;廿三;廿四;廿五;廿六;廿七;廿八;廿九;三十";

var Ys=new Array(arrLen);
Ys[0]=919094400;Ys[1]=949680000;Ys[2]=980265600;
Ys[3]=1013443200;Ys[4]=1044028800;Ys[5]=1074700800;
Ys[6]=1107878400;Ys[7]=1138464000;

var Yn=new Array(arrLen); //农历年的名称
Yn[0]="己卯年";Yn[1]="庚辰年";Yn[2]="辛巳年";
Yn[3]="壬午年";Yn[4]="癸未年";Yn[5]="甲申年";
Yn[6]="乙酉年";Yn[7]="丙戌年";
var D=new Date();
var yy=D.getFullYear();
var mm=D.getMonth()+1;
var dd=D.getDate();
var ww=D.getDay();
if (ww==0) ww="<font color=RED>星期日</font>";
if (ww==1) ww="星期一";
if (ww==2) ww="星期二";
if (ww==3) ww="星期三";
if (ww==4) ww="星期四";
if (ww==5) ww="星期五";
if (ww==6) ww="<font color=green>星期六</font>";
ww=ww;
var ss=parseInt(D.getTime() / 1000);
if (yy<100) yy="19"+yy;

for (i=0;i<arrLen;i++)
if (ss>=Ys[i]){
iyear=i;
sValue=ss-Ys[i]; //当年的秒数
}
dayiy=parseInt(sValue/spd)+1; //当年的天数

var dpm=year1999;
if (iyear==1) dpm=year2000;
if (iyear==2) dpm=year2001;
if (iyear==3) dpm=year2002;
if (iyear==4) dpm=year2003;
if (iyear==5) dpm=year2004;
if (iyear==6) dpm=year2005;
if (iyear==7) dpm=year2006;
dpm=dpm.split(";");

var Mn=month1999;
if (iyear==2) Mn=month2001;
if (iyear==5) Mn=month2004;
if (iyear==7) Mn=month2006;
Mn=Mn.split(";");

var Dn="初一;初二;初三;初四;初五;初六;初七;初八;初九;初十;十一;十二;十三;十四;十五;十六;十七;十八;十九;二十;廿一;廿二;廿三;廿四;廿五;廿六;廿七;廿八;廿九;三十";
Dn=Dn.split(";");

dayim=dayiy;

var total=new Array(13);
total[0]=parseInt(dpm[0]);
for (i=1;i<dpm.length-1;i++) total[i]=parseInt(dpm[i])+total[i-1];
for (i=dpm.length-1;i>0;i--)
if (dayim>total[i-1]){
dayim=dayim-total[i-1];
miy=i;
}
bsWeek=ww;
bsDate=yy+"年"+mm+"月";
bsDate2=dd;
bsYear="农历"+Yn[iyear];
bsYear2=Mn[miy-1]+Dn[dayim];
if (ss>=Ys[7]||ss<Ys[0]) bsYear=Yn[7];
function time(){
var old_time=GetLunarDay(yy,mm,dd);
document.write(bsDate+bsDate2+"日 "+bsWeek+" 农历"+old_time);
}