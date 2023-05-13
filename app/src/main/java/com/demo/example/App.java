package com.demo.example;

import android.app.Application;
import android.content.Context;
public class App extends Application {
    private final String TAG = "App";
    private final Context mContext = this;

    @Override
    public void onCreate() {
        super.onCreate();
    }
}