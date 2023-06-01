package com.demo.example.splash;

import static com.demo.example.App.getRequiredPermissions;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.demo.example.MainActivity;
import com.demo.example.R;

import java.util.ArrayList;
import java.util.List;

public class PermissionGrant_Activity extends AppCompatActivity {
   private SharedPreferences sharedPreferences;
    private static final int ALL_PERMISSIONS = 10;
    private static final String[] REQUIRED_PERMISSIONS = getRequiredPermissions().toArray(new String[0]);
    @Override 
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_grant_permission);
        BtnClicks();
    }
    public void BtnClicks() {
        findViewById(R.id.btn_check).setOnClickListener(new View.OnClickListener() { 
            @Override 
            public void onClick(View view) {
                if (!hasPermissions(PermissionGrant_Activity.this, REQUIRED_PERMISSIONS)) {
                    ActivityCompat.requestPermissions(PermissionGrant_Activity.this, REQUIRED_PERMISSIONS, ALL_PERMISSIONS);
                }else {
                    goToNext();
                }

            }
        });
    }

    private static boolean hasPermissions(Context context, String... permissions) {
        for (String permission : permissions) {
            if (ActivityCompat.checkSelfPermission(context, permission)
                    != PackageManager.PERMISSION_GRANTED) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions,
                                           @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == ALL_PERMISSIONS) {
            boolean allGranted = true;
            for (int result : grantResults) {
                if (result != PackageManager.PERMISSION_GRANTED) {
                    allGranted = false;
                    break;
                }
            }
            if (allGranted) {
                goToNext();
            } else {
                ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, ALL_PERMISSIONS);
            }
        }
    }
    private boolean isFirstTime() {
        
        return sharedPreferences.getBoolean("isFirstTime", true);
    }

    @Override 
    public void onBackPressed() {
        finish();
    }
    public void goToNext(){
        sharedPreferences = getSharedPreferences("MyPrefs", MODE_PRIVATE);
        if (isFirstTime()) {
            Toast.makeText(this, "Welcome to the app!", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, SecondActivity.class).putExtra("isFromSplash", "true"));
            SharedPreferences.Editor editor = sharedPreferences.edit();
            editor.putBoolean("isFirstTime", false);
            editor.apply();
            finish();
        }else {
            startActivity(new Intent(this, MainActivity.class));
            finish();
        }
    }
}
