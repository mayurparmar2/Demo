package com.demo.example;
import android.content.Context;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.viewpager.widget.ViewPager;

import com.demo.example.adapter.ViewPagerAdapter;
import com.demo.example.fragment.HomeFragment;
import com.demo.example.fragment.SettingFragment;
import com.google.android.material.tabs.TabLayout;
public class NewClassName extends AppCompatActivity {
    Context context= this;
    private ViewPagerAdapter mViewPagerAdapter;
    private ViewPager viewPager;
    public int[] tabIcons = {
            R.drawable.icon200,
            R.drawable.settings_icon,
            R.style.Base_TextAppearance_MaterialComponents_Headline6,
    };
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_main_my);
        this.viewPager = (ViewPager) findViewById(R.id.flFragment);
        this.mViewPagerAdapter = new ViewPagerAdapter(getSupportFragmentManager());
        this.mViewPagerAdapter.add(new HomeFragment(), "HOME");
        this.mViewPagerAdapter.add(new SettingFragment(), "SETTINGS");


        this.viewPager.setAdapter(this.mViewPagerAdapter);
        TabLayout tabLayout = (TabLayout) findViewById(R.id.tl_home);
        tabLayout.setupWithViewPager(viewPager);
        tabLayout.getTabAt(0).setIcon(tabIcons[0]);
        tabLayout.getTabAt(1).setIcon(tabIcons[1]);
        tabLayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                tab.getIcon().setTint(ContextCompat.getColor(context,R.color.white));
            }
            @Override
            public void onTabUnselected(TabLayout.Tab tab) {
                tab.getIcon().setTint(ContextCompat.getColor(context,R.color.tabIconTint));
            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });
        tabLayout.selectTab(tabLayout.getTabAt(1));
        tabLayout.selectTab(tabLayout.getTabAt(0));
//        viewPager.setCurrentItem(0);
        this.viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrollStateChanged(int i) {
            }
            @Override
            public void onPageScrolled(int i, float f, int i2) {
            }
            @Override
            public void onPageSelected(int i) {
            }
        });
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
    }
}
