package com.demo.example.splash;

import android.Manifest;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Process;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.demo.example.MainActivity;
import com.demo.example.R;


import java.util.ArrayList;
import java.util.List;

public class SplashScreen extends AppCompatActivity {
    private SharedPreferences sharedPreferences;
    private static final String[] REQUIRED_PERMISSIONS = getRequiredPermissions().toArray(new String[0]);

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        requestWindowFeature(1);
        setContentView(R.layout.activity_splash);
        getWindow().getDecorView().setSystemUiVisibility(8192);
        if (isOnline(this)) {
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    OpenNext1();
                }
            },5000);

        } else {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle("Network error…").setMessage("Internet is not available, reconnect network and try again.").setNegativeButton("OK", new DialogInterface.OnClickListener() {
                @Override
                public final void onClick(DialogInterface dialogInterface, int i) {
                    dialogInterface.cancel();
                    finishAffinity();

                }
            });
            AlertDialog alert = builder.create();
            alert.show();
        }
    }

    public void OpenNext1() {
        if (hasPermissions(this, REQUIRED_PERMISSIONS)) {
            sharedPreferences = getSharedPreferences("MyPrefs", MODE_PRIVATE);
            if (isFirstTime()) {

                Toast.makeText(this, "Welcome to the app!", Toast.LENGTH_SHORT).show();
                startActivity(new Intent(this, SecondActivity.class).putExtra("isFromSplash", "true"));

                SharedPreferences.Editor editor = sharedPreferences.edit();
                editor.putBoolean("isFirstTime", false);
                editor.apply();
            } else {
                startActivity(new Intent(this, MainActivity.class));
                finish();

            }
        } else {
            startActivity(new Intent(this, PermissionGrant_Activity.class));
            finish();
        }
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
    private static List<String> getRequiredPermissions() {
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
    private boolean isFirstTime() {
        return sharedPreferences.getBoolean("isFirstTime", true);
    }
    @Override
    public void onBackPressed() {
        super.onBackPressed();
        ExitApp();
    }
    public void ExitApp() {
        moveTaskToBack(true);
        finish();
        Process.killProcess(Process.myPid());
        System.exit(0);
    }

    public static boolean isOnline(Context cont) {
        ConnectivityManager cm = (ConnectivityManager) cont.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        return netInfo != null && netInfo.isConnectedOrConnecting();
    }
}
