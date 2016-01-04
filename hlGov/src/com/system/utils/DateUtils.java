package com.system.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-24
 * Time: 下午2:14
 * To change this template use File | Settings | File Templates.
 */
public class DateUtils {
    /**
     * 传入日期判断星期几
     *
     * @param pTime
     * @return
     * @throws Exception
     */
    public static int dayForWeek(String pTime) throws Exception {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(format.parse(pTime));
        int dayForWeek = 0;
        if (c.get(Calendar.DAY_OF_WEEK) == 1) {
            dayForWeek = 7;
        } else {
            dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        }
        return dayForWeek;
    }

    /**
     * 获取当前的日期
     * 格式:yyyy-mm-dd
     * @return
     */
    public static String getServerDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(Calendar.getInstance().getTime());
    }

    /**
     * 获取当前的时间
     * 格式：hh:mm:ss
     * @return
     */
    public static String getServerTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.format(Calendar.getInstance().getTime());
    }

    /**
     * 返回当前日期和时间
     * 格式:yyyy-mm-dd hh:mm:ss
     * @return
     */
    public static String getNowTime(){
        return getServerDate()+" "+getServerTime();
    }
}
