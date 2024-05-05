package com.example.loginsignup;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.loginsignup.contact.ContactFragment;
import com.example.loginsignup.cv.cvFragment;
import com.example.loginsignup.home.HomeFragment;
import com.example.loginsignup.portfolio.PortfolioFragment;
import com.example.loginsignup.sidemenu.CallBack;
import com.example.loginsignup.sidemenu.MenuAdapter;
import com.example.loginsignup.sidemenu.MenuItem;
import com.example.loginsignup.sidemenu.MenuUtil;

import java.util.List;

public class MainActivity extends AppCompatActivity implements CallBack {

    Button logout;
    RecyclerView menuRv;
    List<MenuItem> menuItems;
    MenuAdapter adapter;
    int selectedMenuPos = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // setup side menu

        setupSideMenu();

        // set the default fragment when activity launch
        setHomeFragment();

        //setHomeFragment();
        //setcvFragment();
        //setPortfolioFragment();
        //setContactFragment();

        logout = (Button)findViewById(R.id.logout);


        // Set click listener for logout button
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // Call logout method when logout button is clicked
                logout();
            }
        });
    }

    private void setupSideMenu() {

        menuRv = findViewById(R.id.rv_side_menu);

        // get menu list item will get data from a static data class

        menuItems = MenuUtil.getMenuList();
        adapter = new MenuAdapter(menuItems,this);
        menuRv.setLayoutManager(new LinearLayoutManager(this));
        menuRv.setAdapter(adapter);
    }

    void setContactFragment() {
        getSupportFragmentManager().beginTransaction().replace(R.id.container, new ContactFragment()).commit();
    }

    void setPortfolioFragment() {
        getSupportFragmentManager().beginTransaction().replace(R.id.container, new PortfolioFragment()).commit();
    }

    void setcvFragment() {
        getSupportFragmentManager().beginTransaction().replace(R.id.container, new cvFragment()).commit();

    }

    void setHomeFragment(){
        getSupportFragmentManager().beginTransaction().replace(R.id.container,new HomeFragment()).commit();
    }

    // Method to handle logout action
    private void logout() {
        // Here, you can add the necessary logic to perform logout actions
        // For example, navigating back to the login screen
        Intent intent = new Intent(MainActivity.this, LogInActivity.class);
        startActivity(intent);
        finish(); // Finish the current activity
    }

    @Override
    public void onSideMenuItemClick(int i) {

        switch (menuItems.get(i).getCode()) {

            case MenuUtil.HOME_FRAGMENT_CODE:
                setHomeFragment();
                break;
            case MenuUtil.CV_FRAGMENT_CODE:
                setcvFragment();
                break;
            case MenuUtil.PORTFOLIO_FRAGMENT_CODE:
                setPortfolioFragment();
                break;
            case MenuUtil.CONTACT_FRAGMENT_CODE:
                setContactFragment();
                break;
            default:
                setHomeFragment();
        }


        // highlight the selected menu items

        menuItems.get(selectedMenuPos).setSelected(false);
        menuItems.get(i).setSelected(true);
        selectedMenuPos = i;
        adapter.notifyDataSetChanged();


    }
}