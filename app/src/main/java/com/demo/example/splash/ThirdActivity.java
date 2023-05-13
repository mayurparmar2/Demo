package com.demo.example.splash;

import android.content.Intent;


import com.demo.example.adapter.CommonAdapter;
import com.demo.example.base.baseActivity;

import java.util.ArrayList;
import java.util.List;


public class ThirdActivity extends baseActivity {
    List<String> stringList = new ArrayList<>();
    @Override
    public String setTitle() {
        return ThirdActivity.class.getName();
    }
    @Override
    public CommonAdapter setRecyceViewAdapter() {
        stringList.add("English");
        stringList.add("Spanish");
        stringList.add("French");
        stringList.add("German");
        stringList.add("Italian");
        stringList.add("Portuguese");
        stringList.add("Russian");
        stringList.add("Mandarin");
        stringList.add("Japanese");
        stringList.add("Korean");
        stringList.add("Arabic");
        stringList.add("Swahili");
        return new CommonAdapter(this, stringList, new CommonAdapter.CallBack() {
            @Override
            public void onClick(int i) {

            }
        });
    }

    private void launchNextScreen() {
        startActivity(new Intent(this, FourActivity.class));
        finish();
    }
    @Override
    public void next() {
        launchNextScreen();
    }

    @Override
    public void skip() {
        launchNextScreen();
    }

    @Override
    public void backPress() {
        finish();
    }
}