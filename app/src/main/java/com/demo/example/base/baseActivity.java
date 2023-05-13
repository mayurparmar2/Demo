package com.demo.example.base;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.demo.example.R;
import com.demo.example.adapter.CommonAdapter;

public abstract class baseActivity extends AppCompatActivity implements MyInterface {
    private final String TAG = "baseActivity";
    private final Context mContext = this;


    public abstract String setTitle();

    public abstract CommonAdapter setRecyceViewAdapter();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_base_activity);

        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.recycler_view);
        TextView titleText = (TextView) findViewById(R.id.title_text);
        if(setTitle()!=null){
            titleText.setText(setTitle());
        }
        recyclerView.setLayoutManager(new LinearLayoutManager(this, RecyclerView.VERTICAL, false));
       if(setRecyceViewAdapter()!=null){
           recyclerView.setAdapter(setRecyceViewAdapter());
       }
        findViewById(R.id.button_back).setOnClickListener(new View.OnClickListener() {
            @Override
            public final void onClick(View view) {
                onBackPressed();
            }
        });
        findViewById(R.id.button_skip).setOnClickListener(new View.OnClickListener() {
            @Override
            public final void onClick(View view) {
                skip();
            }
        });
        findViewById(R.id.button_next).setOnClickListener(new View.OnClickListener() {
            @Override
            public final void onClick(View view) {
                next();
            }
        });

    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        backPress();
    }
}