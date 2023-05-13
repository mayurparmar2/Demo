package com.demo.example.adapter;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.recyclerview.widget.RecyclerView;
import com.demo.example.R;

import java.util.ArrayList;
import java.util.List;


public class CommonAdapter extends RecyclerView.Adapter<CommonAdapter.ViewHolder> {
    private Activity activity;
    private CallBack callBack;
    private int selectedPosition = 0;
    private List<String> stringList;


    public interface CallBack {
        void onClick(int i);
    }

    public CommonAdapter(Activity activity, List<String> stringList, CallBack callBack) {
        this.activity = null;
        this.stringList = new ArrayList();
        this.callBack = null;
        this.activity = activity;
        this.stringList = stringList;
        this.callBack = callBack;
    }

    @Override 
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new ViewHolder(LayoutInflater.from(this.activity).inflate(R.layout.splash_select_item, parent, false));
    }

    @Override 
    public void onBindViewHolder(ViewHolder holder, final int position) {
        holder.radioButton.setChecked(this.selectedPosition == position);
        holder.textView.setText(this.stringList.get(position));
        holder.itemView.setOnClickListener(new View.OnClickListener() { 
            @Override 
            public final void onClick(View view) {
                CommonAdapter.this.lambda$onBindViewHolder$0$CommonAdapter(position, view);
            }
        });
    }

    public  void lambda$onBindViewHolder$0$CommonAdapter(int position, View view) {
        this.selectedPosition = position;
        notifyDataSetChanged();
        this.callBack.onClick(position);
    }

    @Override 
    public int getItemCount() {
        List<String> list = this.stringList;
        if (list != null) {
            return list.size();
        }
        return 0;
    }


    public class ViewHolder extends RecyclerView.ViewHolder {
        private RadioButton radioButton;
        private TextView textView;
        public ViewHolder(View itemView) {
            super(itemView);
            this.textView = null;
            this.radioButton = null;
            this.textView = (TextView) itemView.findViewById(R.id.text_view);
            this.radioButton = (RadioButton) itemView.findViewById(R.id.radioButton);
        }
    }
}
