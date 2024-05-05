package com.example.loginsignup.sidemenu;

import com.example.loginsignup.R;

import java.util.ArrayList;
import java.util.List;

public class MenuUtil {

    public static final int HOME_FRAGMENT_CODE = 0;
    public static final int CV_FRAGMENT_CODE = 1;
    public static final int PORTFOLIO_FRAGMENT_CODE = 2;
    public static final int CONTACT_FRAGMENT_CODE = 3;

    public static List<MenuItem> getMenuList() {

        List<MenuItem> list = new ArrayList<>();
        // first menu item is selected
        list.add(new MenuItem(R.drawable.baseline_home_24, HOME_FRAGMENT_CODE,true));
        list.add(new MenuItem(R.drawable.baseline_bookmark_added_24, CV_FRAGMENT_CODE,false));
        list.add(new MenuItem(R.drawable.baseline_library_books_24, PORTFOLIO_FRAGMENT_CODE,false));
        list.add(new MenuItem(R.drawable.baseline_contact_mail_24, CONTACT_FRAGMENT_CODE,false));

        return list;

    }
}
