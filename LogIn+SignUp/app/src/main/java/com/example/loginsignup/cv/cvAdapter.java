package com.example.loginsignup.cv;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.loginsignup.R;

import java.util.List;

public class cvAdapter extends RecyclerView.Adapter<cvAdapter.cvViewHolder> {

    List<cvItem> mdata;

    public cvAdapter(List<cvItem> mdata) {
        this.mdata = mdata;
    }

    @NonNull
    @Override
    public cvViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_cv,parent,false);

        return new cvViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull cvViewHolder holder, int position) {

        holder.tvTitle.setText(mdata.get(position).getTitle());
        holder.tvDescription.setText(mdata.get(position).getDescription());


    }

    @Override
    public int getItemCount() {
        return mdata.size();
    }

    public class cvViewHolder extends RecyclerView.ViewHolder {

        TextView tvTitle, tvDescription;

        public cvViewHolder(@NonNull View itemView) {
            super(itemView);
            tvTitle = itemView.findViewById(R.id.item_cv_title);
            tvDescription = itemView.findViewById(R.id.item_cv_desc);
        }
    }
}
