package com.example.loginsignup.portfolio;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.loginsignup.R;

import java.util.List;

public class PortfoliioAdapter extends RecyclerView.Adapter<PortfoliioAdapter.PortfolioViewHolder> {

    List<PortfolioItem> mdata;

    public PortfoliioAdapter(List<PortfolioItem> mdata) {
        this.mdata = mdata;
    }

    @NonNull
    @Override
    public PortfolioViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_portfolio,parent,false);

        return new PortfolioViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PortfolioViewHolder holder, int position) {

        holder.tv_name.setText(mdata.get(position).getName());
        holder.tv_desc.setText(mdata.get(position).getDesc());
        holder.img.setImageResource(mdata.get(position).getImg());


    }


    @Override
    public int getItemCount() {
        return mdata.size();
    }

    public class PortfolioViewHolder extends RecyclerView.ViewHolder {

        TextView tv_name,tv_desc;
        ImageView img;



        public PortfolioViewHolder(@NonNull View itemView) {
            super(itemView);

            tv_name = itemView.findViewById(R.id.portfolio_item_name);
            tv_desc = itemView.findViewById(R.id.portfolio_item_desc);
            img = itemView.findViewById(R.id.portfolio_item_img);
        }
    }
}
