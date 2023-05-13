package com.demo.example.splash;
import android.content.Intent;

import com.demo.example.adapter.CommonAdapter;
import com.demo.example.base.baseActivity;
import java.util.ArrayList;
import java.util.List;


public class SecondActivity extends baseActivity {
    List<String> stringList = new ArrayList<>();
    @Override
    public String setTitle() {
        return SecondActivity.class.getName();
    }
    @Override
    public CommonAdapter setRecyceViewAdapter() {
        stringList.add("India");
        stringList.add("Spain");
        stringList.add("France");
        stringList.add("Germany");
        stringList.add("Italy");
        stringList.add("Portugal");
        stringList.add("Belgium");
        stringList.add("Netherlands");
        stringList.add("Switzerland");
        stringList.add("Austria");
        stringList.add("Norway");
        stringList.add("Sweden");
        stringList.add("Denmark");
        stringList.add("Finland");
        stringList.add("Russia");
        stringList.add("Ukraine");
        stringList.add("Poland");
        stringList.add("Hungary");
        stringList.add("Greece");
        stringList.add("Turkey");
        stringList.add("Egypt");
        stringList.add("South Africa");
        stringList.add("Nigeria");
        stringList.add("Kenya");
        stringList.add("Ghana");
        stringList.add("Pakistan");
        stringList.add("Bangladesh");
        stringList.add("Sri Lanka");
        stringList.add("China");
        stringList.add("Japan");
        stringList.add("South Korea");
        stringList.add("Indonesia");
        stringList.add("Australia");
        stringList.add("New Zealand");
        stringList.add("Fiji");
        stringList.add("Samoa");
        stringList.add("Tonga");
        stringList.add("Solomon Islands");
        stringList.add("Vanuatu");
        stringList.add("Papua New Guinea");
        stringList.add("United Arab Emirates");
        stringList.add("Saudi Arabia");
        stringList.add("Iran");
        stringList.add("Iraq");
        stringList.add("Israel");
        stringList.add("Jordan");
        stringList.add("Lebanon");
        stringList.add("Syria");
        stringList.add("Yemen");
        return new CommonAdapter(this, stringList, new CommonAdapter.CallBack() {
            @Override
            public void onClick(int i) {

            }
        });
    }

    private void launchNextScreen() {
        startActivity(new Intent(this, ThirdActivity.class));
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
