package com.demo.example.splash;

import android.content.Intent;

import com.demo.example.MainActivity;
import com.demo.example.adapter.CommonAdapter;
import com.demo.example.base.baseActivity;

import java.util.ArrayList;
import java.util.List;


public class FiveActivity extends baseActivity {
    List<String> stringList = new ArrayList<>();

    @Override
    public String setTitle() {
        return FiveActivity.class.getName();
    }

    @Override
    public CommonAdapter setRecyceViewAdapter() {
        stringList.add("MP4");
        stringList.add("MOV");
        stringList.add("AVI");
        stringList.add("WMV");
        stringList.add("FLV");
        stringList.add("MKV");

        return new CommonAdapter(this, stringList, new CommonAdapter.CallBack() {
            @Override
            public void onClick(int i) {

            }
        });
    }

    private void launchNextScreen() {
        startActivity(new Intent(this, MainActivity.class));
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