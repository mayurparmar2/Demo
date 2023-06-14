package com.demo.example;

import android.Manifest;
import android.app.Application;
import android.content.Context;
import android.os.Build;

import java.util.ArrayList;
import java.util.List;

public class App extends Application {
    public static Context getContext() {
        return context;
    }
    public static Context context;
    private static final String[] REQUIRED_PERMISSIONS = getRequiredPermissions().toArray(new String[0]);
    private final String TAG = "App";
    public static List<String> getRequiredPermissions() {
        List<String> permissions = new ArrayList<>();
        permissions.add(Manifest.permission.READ_PHONE_STATE);
        permissions.add(Manifest.permission.CAMERA);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            permissions.add(Manifest.permission.READ_MEDIA_IMAGES);
            permissions.add(Manifest.permission.READ_MEDIA_VIDEO);
            permissions.add(Manifest.permission.POST_NOTIFICATIONS);
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            permissions.add(Manifest.permission.WRITE_EXTERNAL_STORAGE);
            permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE);

        }
        return permissions;
    }
    @Override
    public void onCreate() {
        super.onCreate();
        context=this;
    }
}

